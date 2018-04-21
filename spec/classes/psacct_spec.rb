require 'spec_helper'

describe 'psacct' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      case os_facts[:os]['name']
      when 'Debian', 'Ubuntu'
        packages = ['acct']
        service = 'acct'
      when 'Fedora', 'RedHat', 'CentOS', 'Scientific', 'OracleLinux'
        packages = ['psacct']
        service = 'psacct'
      when 'SLES', 'SLED'
        packages = ['acct']
        service = 'acct'
      end

      context 'with default values' do
        it { is_expected.to compile }

        it {
          is_expected.to contain_class('psacct::install')
            .that_notifies('Class[psacct::service]')
        }

        it {
          is_expected.to contain_class('psacct::config')
            .that_requires('Class[psacct::install]')
        }

        it {
          is_expected.to contain_class('psacct::service')
            .that_requires('Class[psacct::config]')
        }

        it {
          expect(packages).not_to be_nil

          packages.each do |package|
            is_expected.to contain_package(package)
          end
        }

        it {
          expect(service).not_to be_nil

          is_expected.to contain_service(service).with(
            'ensure' => 'running',
            'enable' => true,
          )
        }

        it {
          is_expected.to contain_exec('psacct::service::check').with(
            'command' => '/bin/true',
            'notify'  => "Service[#{service}]",
          )
        }
      end

      context 'disabled' do
        let(:params) { { 'enabled' => false } }

        it { is_expected.to compile }
        it { is_expected.to contain_class('psacct::service') }
        it { is_expected.not_to contain_class('psacct::config') }
        it { is_expected.not_to contain_exec('psacct::service::check') }

        it {
          is_expected.to contain_class('psacct::install')
            .that_requires('Class[psacct::service]')
        }

        it {
          expect(packages).not_to be_nil

          packages.each do |package|
            is_expected.to contain_package(package).with(
              'ensure' => 'absent',
            )
          end
        }

        it {
          expect(service).not_to be_nil

          is_expected.to contain_service(service).with(
            'ensure' => 'stopped',
            'enable' => false,
          )
        }
      end

      context 'all custom params' do
        let(:params) do
          {
            'enabled'                 => true,
            'logging'                 => 666,
            'manage_etc_default_acct' => true,
            'logfile'                 => '/tmp/foo',
            'packages'                => %w[foo1 foo2],
            'service'                 => 'foo',
          }
        end

        it { is_expected.to compile }
        it { is_expected.to contain_class('psacct::install') }
        it { is_expected.to contain_class('psacct::config') }
        it { is_expected.to contain_class('psacct::service') }
        it { is_expected.to contain_package('foo1') }
        it { is_expected.to contain_package('foo2') }
        it { is_expected.to contain_service('foo') }

        it {
          is_expected.to contain_augeas('psacct::config::etc_default_acct').with(
            'changes' => [
              "set ACCT_ENABLE '\"1\"'",
              "set ACCT_LOGGING '\"666\"'",
            ],
          )
        }
      end

      context 'disable manage_etc_default_acct' do
        let(:params) do
          {
            'enabled'                 => true,
            'manage_etc_default_acct' => false,
          }
        end

        it { is_expected.not_to contain_augeas('psacct::config::etc_default_acct') }
      end
    end
  end
end

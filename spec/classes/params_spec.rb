require 'spec_helper'

describe 'psacct::params' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('psacct::params') }
      it { is_expected.to have_resource_count(0) }
    end
  end
end

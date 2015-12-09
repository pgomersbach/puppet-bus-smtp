require 'spec_helper'

describe 'bussmtp' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "bussmtp class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('bussmtp') }
 
          it { is_expected.to contain_class('bussmtp::params') }
          it { is_expected.to contain_class('bussmtp::install').that_comes_before('bussmtp::config') }
          it { is_expected.to contain_class('bussmtp::config') }
          it { is_expected.to contain_class('bussmtp::service').that_subscribes_to('bussmtp::config') }

          it { is_expected.to contain_service('bussmtp') }
          it { is_expected.to contain_package('bussmtp').with_ensure('present') }

        end
      end
    end
  end
end

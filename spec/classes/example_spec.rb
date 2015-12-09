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

          it { is_expected.to contain_package('git').with_ensure('present') }
          it { is_expected.to contain_package('ruby').with_ensure('present') }
          it { is_expected.to contain_package('mini-smtp-server').with_provider('gem') }
          it { is_expected.to contain_package('net-ping').with_provider('gem') }
          it { is_expected.to contain_package('thin').with_provider('gem') }

          it { is_expected.to contain_file('/opt') }
          it { is_expected.to contain_vcsrepo('/opt/bussmtp') }

          it { is_expected.to contain_file('bussmtp.init') }
          it { is_expected.to contain_file('bussmtpconfigdir') }
          it { is_expected.to contain_file('bussmtp.yaml') }
          it { is_expected.to contain_logrotate__rule('bussmtp.logrotate') }

          it { is_expected.to contain_service('bussmtp') }
        end
      end
    end

    context "On a Debian OS with no package name specified" do
      let :facts do
        {
          :osfamily => 'Debian'
        }
      end

      it { is_expected.to contain_package('apache2') }
      it { is_expected.to contain_service('apache2') }
    end

    context "On a RedHat OS with no package name specified" do
      let :facts do
        {
          :osfamily => 'RedHat'
        }
      end

      it { is_expected.to contain_package('httpd') }
      it { is_expected.to contain_service('httpd') }
    end

    context "On an unknown OS with no package name specified" do
      let :facts do
        {
          :osfamily => 'Darwin'
        }
      end

      it {
        expect { should raise_error(Puppet::Error) }
      }
    end
  end
end

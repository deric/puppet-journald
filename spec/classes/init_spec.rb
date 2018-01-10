require 'spec_helper'

describe 'journald' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('journald') }
    it { is_expected.to contain_class('journald::params') }
    it { is_expected.to contain_service('systemd-journald') }
  end

  context 'optionaly managed service' do
    let :pre_condition do
      'class {"journald":
         manage_service => false
       }'
    end

    it do
      is_expected.not_to contain_service('systemd-journald')
    end
  end

  context 'journald settings' do
    let :pre_condition do
      'class {"journald":
         options => {"Storage" => "auto"},
       }'
    end

    it do
      is_expected.to contain_ini_setting('/etc/systemd/journald.conf [Journal] Storage').with(
        ensure: 'present', section: 'Journal',
        setting: 'Storage', value: 'auto',
        path: '/etc/systemd/journald.conf'
      )
    end
  end
end

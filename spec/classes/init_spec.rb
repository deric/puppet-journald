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
end

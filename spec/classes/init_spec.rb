require 'spec_helper'

describe 'journald' do
  context 'with default values for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('journald') }
    it { is_expected.to contain_class('journald::params') }
  end
end

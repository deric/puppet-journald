require 'spec_helper'
describe 'journald' do
  context 'with default values for all parameters' do
    it { should contain_class('journald') }
  end
end

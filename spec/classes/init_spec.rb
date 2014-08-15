require 'spec_helper'
describe 'ip_addr' do

  context 'with defaults for all parameters' do
    it { should contain_class('ip_addr') }
  end
end

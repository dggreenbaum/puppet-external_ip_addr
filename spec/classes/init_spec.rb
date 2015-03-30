require 'spec_helper'
describe 'external_ip_addr' do

  context 'with defaults for all parameters' do
    it { should contain_class('external_ip_addr') }
  end
end

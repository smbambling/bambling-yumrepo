require 'spec_helper'
describe 'yumrepo' do

  context 'with defaults for all parameters' do
    it { should contain_class('yumrepo') }
  end
end

require 'spec_helper'
describe 'aprsd' do

  context 'with defaults for all parameters' do
    it { should contain_class('aprsd') }
  end
end

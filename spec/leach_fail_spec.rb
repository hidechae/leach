require 'spec_helper'

describe 'Leach Fail' do
  it 'Invalid parameter' do
    parameters = 'invalid parameter'
    expect do
      Leach.filter(parameters)
    end.to raise_error(Leach::Error::InvalidType)
  end
end

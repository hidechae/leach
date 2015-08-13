require 'spec_helper'

describe 'Leach Fail' do
  it 'Required key not found' do
    parameters = {}
    expect do
      Leach.filter(parameters) do
        requires :key, type: Integer
      end
    end.to raise_error(Leach::Error::NotFound)
  end

  it 'Invalid parameter' do
    parameters = 'invalid parameter'
    expect do
      Leach.filter(parameters)
    end.to raise_error(Leach::Error::InvalidType)
  end

  it 'Invalid type for ArrayParameter' do
    expect do
      Leach::Parameters::ArrayParameter.new({})
    end.to raise_error(Leach::Error::InvalidType)
  end

  it 'Invalid type for HashParameter' do
    expect do
      Leach::Parameters::HashParameter.new([])
    end.to raise_error(Leach::Error::InvalidType)
  end
end

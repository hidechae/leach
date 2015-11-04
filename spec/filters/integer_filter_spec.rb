require 'spec_helper'

describe Leach::Filters::IntegerFilter do
  it 'Integer values' do
    parameters = { key: '1234' }
    expected   = { key: 1234 }
    actual = Leach.filter(parameters) do
      requires :key, type: Integer, max: 10000, min: 0
    end
    expect(actual).to eq(expected)
  end

  describe Exception do
    it 'Validation max' do
      parameters = { key: 100 }
      expect do
        Leach.filter(parameters) do
          requires :key, type: Integer, max: 10
        end
      end.to raise_error(Leach::Error::InvalidValue)
    end

    it 'Validation min' do
      parameters = { key: 1 }
      expect do
        Leach.filter(parameters) do
          requires :key, type: Integer, min: 10
        end
      end.to raise_error(Leach::Error::InvalidValue)
    end

  end
end

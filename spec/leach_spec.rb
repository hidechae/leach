require 'spec_helper'

describe Leach do
  it 'has a version number' do
    expect(Leach::VERSION).not_to be nil
  end

  it 'Array parameters' do
    parameters = [ 'hello', 'world' ]
    expected   = [ :hello,  :world ]
    actual = Leach.filter(parameters) do
      requires type: Symbol
    end
    expect(actual).to eq(expected)
  end

  it 'String values' do
    parameters = { key: 1234 }
    expected   = { key: '1234' }
    actual = Leach.filter(parameters) do
      requires :key, type: String
    end
    expect(actual).to eq(expected)
  end

  it 'Symbol values' do
    parameters = { key: 'hello' }
    expected   = { key: :hello }
    actual = Leach.filter(parameters) do
      requires :key, type: Symbol
    end
    expect(actual).to eq(expected)
  end

  it 'Date values' do
    parameters = { key: '2015/01/01' }
    expected   = { key: Date.parse('2015/01/01') }
    actual = Leach.filter(parameters) do
      requires :key, type: Date
    end
    expect(actual).to eq(expected)
  end

  it 'Time values' do
    parameters = { key: '2015/01/01 01:23:45' }
    expected   = { key: Time.parse('2015/01/01 01:23:45') }
    actual = Leach.filter(parameters) do
      requires :key, type: Time
    end
    expect(actual).to eq(expected)
  end

  it 'Array values' do
    parameters = { key: %w(1 2 3) }
    expected   = { key: [1, 2, 3] }
    actual = Leach.filter(parameters) do
      requires :key, type: Array do
        requires type: Integer
      end
    end
    expect(actual).to eq(expected)
  end

  it 'Array values in array' do
    parameters = { key: [%w(1 2), %w(3 4), %w(5 6)] }
    expected   = { key: [[1, 2], [3, 4], [5, 6]] }
    actual = Leach.filter(parameters) do
      requires :key, type: Array do
        requires type: Array do
          requires type: Integer
        end
      end
    end
    expect(actual).to eq(expected)
  end

  it 'Hash values' do
    parameters = { key: { key1: '1234', key2: 'hello' }}
    expected   = { key: { key1: 1234,   key2: :hello  }}
    actual = Leach.filter(parameters) do
      requires :key, type: Hash do
        requires :key1, type: Integer
        requires :key2, type: Symbol
      end
    end
    expect(actual).to eq(expected)
  end

  it 'Hash values cast to Array' do
    parameters = {
      key: { key1: { key11: '1234', key12: 'hello' },
             key2: { key11: '1234', key12: 'hello' }}
    }
    expected = {
      key: [{ key11: 1234, key12: :hello },
            { key11: 1234, key12: :hello }]
    }
    actual = Leach.filter(parameters) do
      requires :key, type: Array do
        requires type: Hash do
          requires :key11, type: Integer
          requires :key12, type: Symbol
        end
      end
    end
    expect(actual).to eq(expected)
  end

  it 'Optional parameter' do
    parameters = { key1: '1234' }
    expected   = { key1: 1234, key2: nil }
    actual = Leach.filter(parameters) do
      requires :key1, type: Integer
      optional :key2, type: Symbol
    end
    expect(actual).to eq(expected)
  end

  it 'Optional parameter using default' do
    parameters = { key1: '1234' }
    expected   = { key1: 1234, key2: :hello }
    actual = Leach.filter(parameters) do
      requires :key1, type: Integer
      optional :key2, type: Symbol, default: :hello
    end
    expect(actual).to eq(expected)
  end

  it 'Optional parameter having value' do
    parameters = { key1: '1234', key2: 'hello' }
    expected   = { key1: 1234, key2: :hello }
    actual = Leach.filter(parameters) do
      requires :key1, type: Integer
      optional :key2, type: Symbol, default: :world
    end
    expect(actual).to eq(expected)
  end

  describe Exception do
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
end

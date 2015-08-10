require 'spec_helper'
require 'date'
require 'time'

describe Leach do
  it 'has a version number' do
    expect(Leach::VERSION).not_to be nil
  end

  it 'type filter' do
    parameters = {
      integer:            '1',
      string:             'string',
      symbol:             'symbol',
      date:               '2015/01/01',
      time:               '2015/01/01 12:34:56',
      array_integer:      %w(1 2 3),
      array_array:        [%w(1 2 3),
                           %w(4 5 6)],
      array_hash:         [{ id: '1',
                             name: 'item1' },
                           { id: '2',
                             name: 'item2' }],
      hash_to_array:      { '1' => '1', '2' => '2', '3' => '3' },
      hash_to_array_hash: { '1' => { id: '1',
                                     name: 'item1' },
                            '2' => { id: '2',
                                     name: 'item2' } },
      hash:               { id:   '1',
                            name: 'item' }
    }

    expected_params = {
      integer:            1,
      string:             'string',
      symbol:             :symbol,
      date:               Date.parse('2015/01/01'),
      time:               Time.parse('2015/01/01 12:34:56'),
      array_integer:      [1, 2, 3],
      array_array:        [[1, 2, 3],
                           [4, 5, 6]],
      array_hash:         [{ id: 1,
                             name: 'item1' },
                           { id: 2,
                             name: 'item2' }],
      hash_to_array:      [1, 2, 3],
      hash_to_array_hash: [{ id: 1,
                             name: 'item1' },
                           { id: 2,
                             name: 'item2' }],
      hash:               { id: 1,
                            name: 'item' }
    }

    filtered_parameters = Leach.filter(parameters) do
      requires :integer, type: Integer
      requires :string, type: String
      requires :symbol, type: Symbol
      requires :date, type: Date
      requires :time, type: Time
      requires :array_integer, type: Array do
        requires type: Integer
      end
      requires :array_array, type: Array do
        requires type: Array do
          requires type: Integer
        end
      end
      requires :array_hash, type: Array do
        requires type: Hash do
          requires :id, type: Integer
          requires :name, type: String
        end
      end
      requires :hash_to_array, type: Array do
        requires type: Integer
      end
      requires :hash_to_array_hash, type: Array do
        requires type: Hash do
          requires :id, type: Integer
          requires :name, type: String
        end
      end
      requires :hash, type: Hash do
        requires :id, type: Integer
        requires :name, type: String
      end
    end

    expect(filtered_parameters).to eq(expected_params)
  end
end

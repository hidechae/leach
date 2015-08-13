require 'date'

module Leach
  module Filters
    class DateFilter
      class << self
        def run(value, **options)
          cast(value)
        end

        def cast(value)
          Date.parse(value)
        end
      end
    end
  end
end

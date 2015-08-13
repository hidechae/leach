require 'time'

module Leach
  module Filters
    class TimeFilter
      class << self
        def run(value, **options)
          cast(value)
        end

        def cast(value)
          Time.parse(value)
        end
      end
    end
  end
end

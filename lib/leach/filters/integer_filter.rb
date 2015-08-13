module Leach
  module Filters
    class IntegerFilter
      class << self
        def run(value, max: nil, min: nil)
          value = cast(value)
          max(value, max) if max
          min(value, min) if min
          value
        end

        private

        def cast(value)
          Integer(value)
        end

        def max(value, max)
          if value > max
            fail Leach::Error::InvalidValue, "Integer value #{value} should be smaller than #{max}"
          end
        end

        def min(value, min)
          if value < min
            fail Leach::Error::InvalidValue, "Integer value #{value} should be bigger than #{min}"
          end
        end
      end
    end
  end
end

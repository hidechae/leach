module Leach
  module Filters
    class ArrayFilter
      class << self
        def run(value, **options)
          cast(value)
        end

        def cast(value)
          case value
          when Hash then value.values
          else Array(value)
          end
        end
      end
    end
  end
end

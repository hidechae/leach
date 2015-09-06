module Leach
  module Filters
    class BooleanFilter
      class << self
        def run(value, **options)
          cast(value)
        end

        def cast(value)
          !!value
        end
      end
    end
  end
end

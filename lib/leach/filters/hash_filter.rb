module Leach
  module Filters
    class HashFilter
      class << self
        def run(value, **options)
          cast(value)
        end

        def cast(value)
          value.to_h
        end
      end
    end
  end
end

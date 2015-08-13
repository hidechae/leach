module Leach
  module Filters
    class IntegerFilter < Base
      class << self
        def run(value, *options)
          cast(value)
        end

        def cast(value)
          Integer(value)
        end
      end
    end
  end
end

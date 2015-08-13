module Leach
  module Filters
    class StringFilter < Base
      class << self
        def run(value, **options)
          cast(value)
        end

        def cast(value)
          String(value)
        end
      end
    end
  end
end

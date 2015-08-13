module Leach
  module Filters
    class SymbolFilter
      class << self
        def run(value, *options)
          cast(value)
        end

        def cast(value)
          String(value).to_sym
        end
      end
    end
  end
end

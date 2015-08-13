module Leach
  module Filters
    class SymbolFilter < Base
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

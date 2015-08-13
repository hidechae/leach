module Leach
  module Filters
    class Base
      class << self
        def type
          const_get(self.name.match(/Filters::(.*)Filter/)[1])
        end
      end
    end
  end
end

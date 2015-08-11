module Leach
  module Helper
    private

    def integer_class?
      ->v { v.equal?(Integer) }
    end

    def string_class?
      ->v { v.equal?(String) }
    end

    def symbol_class?
      ->v { v.equal?(Symbol) }
    end

    def date_class?
      ->v { v.equal?(Date) }
    end

    def time_class?
      ->v { v.equal?(Time) }
    end

    def hash_class?
      ->v { v.equal?(Hash) }
    end

    def array_class?
      ->v { v.equal?(Array) }
    end
  end
end

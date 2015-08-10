module Leach
  module Helper
    private

    def integer?
      ->v { v.instance_of?(Integer) }
    end

    def string?
      ->v { v.instance_of?(String) }
    end

    def symbol?
      ->v { v.instance_of?(Symbol) }
    end

    def date?
      ->v { v.instance_of?(Date) }
    end

    def time?
      ->v { v.instance_of?(Time) }
    end

    def hash?
      ->v { v.instance_of?(Hash) }
    end

    def array?
      ->v { v.instance_of?(Array) }
    end

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

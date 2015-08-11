module Leach
  module Filter
    private

    def cast_type(value, type)
      case type
      when integer_class?, string_class?, hash_class?
        send(type.to_s, value)
      when array_class?
        case value
        when Hash then value.values
        else send(type.to_s, value)
        end
      when symbol_class?
        String(value).to_sym
      when date_class?, time_class?
        type.send(:parse, String(value))
      else
        fail NotImplementedError, "couldn't cast to #{type}"
      end
    end
  end
end

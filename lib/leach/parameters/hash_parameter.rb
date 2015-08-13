module Leach
  module Parameters
    class HashParameter
      attr_reader :params

      def initialize(row_params, &block)
        unless row_params.instance_of?(Hash)
          fail Leach::Error::InvalidType, "Invalid type `#{row_params.class.name}`"
        end

        @row_params = row_params
        @params = {}
        instance_eval(&block)
      end

      def requires(key, type:, **options, &block)
        unless @row_params.key?(key)
          fail Leach::Error::NotFound, "Required key `#{key}` not found."
        end
        set_params(key, type: type, **options, &block)
      end

      def optional(key, type:, default: nil, **options, &block)
        if @row_params.key?(key)
          set_params(key, type: type, **options, &block)
        else
          @params.store(key, default)
        end
      end

      private

      def set_params(key, type:, **options, &block)
        value = @row_params[key]
        value = Filter.run(value, type: type, **options)
        value = Leach.filter(value, &block) if block_given?
        @params.store(key, value)
      end
    end
  end
end

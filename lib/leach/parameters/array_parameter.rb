module Leach
  module Parameters
    class ArrayParameter
      attr_reader :params

      def initialize(row_params, &block)
        unless row_params.instance_of?(Array)
          fail Leach::Error::InvalidType, "Invalid type `#{row_params.class.name}`"
        end

        @row_params = row_params
        @params = []
        instance_eval(&block)
      end

      def requires(type:, **option, &block)
        set_params(type: type, &block)
      end
      alias_method :optional, :requires

      private

      def set_params(type:, **options, &block)
        @row_params.each do |value|
          value = Filter.run(value, type: type, **options)
          value = Leach.filter(value, &block) if block_given?
          @params.push(value)
        end
      end
    end
  end
end

module Leach
  class HashParameters
    include Leach::Helper
    include Leach::Filter

    def initialize(row_params, &block)
      fail unless row_params.instance_of?(Hash)
      @row_params = row_params
      @params = {}

      instance_eval(&block)
    end

    def requires(key, type:, &block)
      fail "`#{key}` is required" unless @row_params.key?(key)
      filter(key, type: type, &block)
    end

    def optional(key, type:, &block)
      return unless @row_params.key?(key)
      filter(key, type: type, &block)
    end

    def to_params
      @params
    end

    private

    def filter(key, type:, &block)
      value = @row_params[key]
      value = cast_type(value, type) if type

      if block_given?
        value =
          case value
          when array? then ArrayParameters.new(value, &block)
          when hash?  then self.class.new(value, &block)
          else fail
          end.to_params
      end

      @params.store(key, value)
    end
  end
end

module Leach
  class HashParameters
    def initialize(row_params, &block)
      fail unless row_params.instance_of?(Hash)
      @row_params = row_params
      @params = {}

      instance_eval(&block)
    end

    def requires(key, type:, **options, &block)
      fail "`#{key}` is required" unless @row_params.key?(key)
      set_params(key, type: type, **options, &block)
    end

    def optional(key, type:, default: nil, **options, &block)
      unless @row_params.key?(key)
        @params.store(key, default)
      else
        set_params(key, type: type, **options, &block)
      end
    end

    def to_params
      @params
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

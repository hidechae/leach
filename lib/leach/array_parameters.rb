module Leach
  class ArrayParameters
    def initialize(row_params, &block)
      fail unless row_params.instance_of?(Array)
      @row_params = row_params
      @params = []

      instance_eval(&block)
    end

    def requires(type:, **option, &block)
      set_params(type: type, &block)
    end
    alias_method :optional, :requires

    def to_params
      @params
    end

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

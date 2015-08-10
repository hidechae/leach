module Leach
  class ArrayParameters
    include Leach::Helper
    include Leach::Filter

    def initialize(row_params, &block)
      fail unless row_params.instance_of?(Array)
      @row_params = row_params
      @params = []

      instance_eval(&block)
    end

    def requires(type:, &block)
      filter(type: type, &block)
    end
    alias_method :optional, :requires

    def to_params
      @params
    end

    private

    def filter(type:, &block)
      values = @row_params
      values = values.map { |v| cast_type(v, type) } if type

      if block_given?
        values = values.map do |value|
          case value
          when array? then self.class.new(value, &block)
          when hash?  then HashParameters.new(value, &block)
          else fail
          end.to_params
        end
      end

      @params = values
    end
  end
end

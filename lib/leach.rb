require 'leach/version'
require 'leach/filter'
require 'leach/array_parameters'
require 'leach/hash_parameters'
require 'leach/error/invalid_type'
require 'leach/error/not_found'

module Leach
  class << self
    def filter(parameters, &block)
      case parameters
      when Array then Leach::ArrayParameters.new(parameters, &block)
      when Hash  then Leach::HashParameters.new(parameters, &block)
      else fail Leach::Error::InvalidType, "Invalid type `#{parameters.class.name}`"
      end.to_params
    end
  end
end

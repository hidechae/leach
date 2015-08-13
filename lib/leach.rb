require 'leach/version'
require 'leach/filter'
require 'leach/parameters/array_parameter'
require 'leach/parameters/hash_parameter'
require 'leach/error/invalid_type'
require 'leach/error/not_found'

module Leach
  class << self
    def filter(parameters, &block)
      case parameters
      when Array then Leach::Parameters::ArrayParameter.new(parameters, &block)
      when Hash  then Leach::Parameters::HashParameter.new(parameters, &block)
      else fail Leach::Error::InvalidType, "Invalid type `#{parameters.class.name}`"
      end.to_params
    end
  end
end

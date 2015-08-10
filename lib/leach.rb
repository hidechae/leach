require "leach/version"
require "leach/filter"
require "leach/helper"
require "leach/array_parameters"
require "leach/hash_parameters"

module Leach
  class << self
    def filter(parameters, &block)
      case parameters
      when Array
        Leach::AraryParameters.new(parameters, &block)
      when Hash
        Leach::HashParameters.new(parameters, &block)
      else
        fail
      end.to_params
    end
  end
end

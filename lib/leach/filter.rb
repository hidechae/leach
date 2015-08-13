require 'leach/filters/base'
require 'leach/filters/integer_filter'
require 'leach/filters/string_filter'
require 'leach/filters/symbol_filter'
require 'leach/filters/array_filter'
require 'leach/filters/hash_filter'
require 'leach/filters/date_filter'
require 'leach/filters/time_filter'

module Leach
  class Filter
    class << self
      def run(value, type:, **options)
        const_get("Leach::Filters::#{type}Filter").run(value, **options)
      end
    end
  end
end

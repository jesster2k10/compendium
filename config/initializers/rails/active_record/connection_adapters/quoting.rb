# ActiveRecord doesn't know how to handle SimpleDelegators when creating SQL
# This means that when passing a SimpleDelegator (ie. Compendium::Param) into ActiveRecord::Base.find, it'll
# crash.
# Override AR::ConnectionAdapters::Quoting to forward a SimpleDelegator's object to be quoted.

module QuoteWithSimpleDelegator
  def quote(value, column = nil)
    return value.quoted_id if value.respond_to?(:quoted_id)
    value = value.__getobj__ if value.is_a?(SimpleDelegator)
    super
  end
end

module ActiveRecord
  module ConnectionAdapters
    module Quoting
      prepend QuoteWithSimpleDelegator
    end
  end
end

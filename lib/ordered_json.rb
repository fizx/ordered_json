require "rubygems"
require 'collections/sequenced_hash'
require File.dirname(__FILE__) + "/../ext/ordered_json_c"

class OrderedHash < SequencedHash; end

module OrderedJSON
  def parse(str)
    ::OrderedJSONC.parse(str, OrderedHash)
  end
  
  def dump(obj)
    ::OrderedJSONC.dump(obj)
  end
  
  extend self
end
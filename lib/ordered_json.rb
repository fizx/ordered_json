require "rubygems"
require 'collections/sequenced_hash'

class OrderedHash < SequencedHash; end

module OrderedJSON
  class ParseError < RuntimeError; end
  class DumpError < RuntimeError; end
  
  
  def parse(str)
    ::OrderedJSONC.parse(str, OrderedHash)
  end
  
  def dump(obj)
    ::OrderedJSONC.dump(obj)
  end
  
  extend self
end

require File.dirname(__FILE__) + "/../ext/ordered_json_c"

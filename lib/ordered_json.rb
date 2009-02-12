require File.dirname(__FILE__) + "/ordered_hash"
require File.dirname(__FILE__) + "/../ext/ordered_json_c"
module OrderedJSON
  def parse(str)
    return ::OrderedJSONC.parse(str)
  end
  
  extend self
end
require "test/unit"
require File.dirname(__FILE__) + "/../lib/ordered_json"
require "json"

class OrderedJSONTest < Test::Unit::TestCase
  def test_parse_nothing
    assert_equal OrderedHash.new, OrderedJSON.parse("{}")
  end
  
  def test_parsed_json_maintains_order
    h = OrderedHash.new
    h["aaaa"] = "bbbb"
    h["b"] = "c"
    h["c"] = "d"
    h["d"] = "e"
    h["1"] = "2"
    assert_equal "{\"aaaa\"=>\"bbbb\", \"b\"=>\"c\", \"c\"=>\"d\", \"d\"=>\"e\", \"1\"=>\"2\"}", h.inspect
    assert_equal "{\"aaaa\":\"bbbb\", \"b\":\"c\", \"c\":\"d\", \"d\":\"e\", \"1\":\"2\"}", OrderedJSON.dump(h)
    
    parsed = OrderedJSON.parse(JSON.dump(h))
    
    assert_equal h.inspect, parsed.inspect
    assert_kind_of OrderedHash, parsed
  end
end
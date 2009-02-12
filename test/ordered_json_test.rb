require "test/unit"
require File.dirname(__FILE__) + "/../lib/ordered_json"

class OrderedJSONTest < Test::Unit::TestCase
  def test_parse_nothing
    assert_equal OrderedHash.new, OrderedJSON.parse("{}")
  end
end
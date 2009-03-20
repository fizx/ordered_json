require "test/unit"
require File.dirname(__FILE__) + "/../lib/ordered_json"
require "json"

class OrderedJSONTest < Test::Unit::TestCase
  
  def test_parse_nothing
    assert_equal OrderedHash.new, OrderedJSON.parse("{}")
  end
  
  def test_simple_dump
    assert_equal "{ }", OrderedJSON.dump({})
  end
  
  def test_crash_parse
    OrderedJSON.parse(File.read(File.dirname(__FILE__) + "/crash.json"))
  end
  
  def test_crash_example
    @ruby = eval(File.read(File.dirname(__FILE__) + "/crashing_example.rb"))
    json = OrderedJSON.dump(@ruby)
    @back = OrderedJSON.parse(json)
    assert_equal(@ruby, @back)
    
    # puts @back.inspect
    
    json = OrderedJSON.pretty_dump(@ruby)
    @back = OrderedJSON.parse(json)
    assert_equal(@ruby, @back)
  end
  
  def test_invalid_json
    assert_raises(OrderedJSON::ParseError) do
      OrderedJSON.parse("not json")
    end
  end
    
  def test_pretty_dump
    
    assert_equal File.read(File.dirname(__FILE__) + "/pretty.json"), 
      OrderedJSON.pretty_dump({"foo" => "bar", 
        "bar" => [{"dsfa" => {"asdf" => ["dsaf", nil]}}]
      })
          
    assert_equal %[{\n\t"foo": "bar"\n}], OrderedJSON.pretty_dump({"foo" => "bar"})
  end
  
  def test_some_cases
    obj = {"foo"=>{"bar"=>nil}}
    OrderedJSON.dump(obj)
    
    obj = OrderedHash.new
    obj["foo"] = {"bar"=>nil}
    OrderedJSON.dump(obj)
    
    obj = OrderedHash.new
    obj["foo"] = OrderedHash.new
    OrderedJSON.dump(obj)
  end
  
  # The idea is to take random numericish keys with ordered 
  # alphabetic values, and assert that when we inspect various 
  # parts of the process, despite the random keys, the values are still
  # ordered.  See the values scan in assert_alphabet
  def test_parsed_json_maintains_order
    original = create_random_hash
    dump     = OrderedJSON.dump(original)
    parsed   = OrderedJSON.parse(dump)
  
    assert_kind_of OrderedHash, parsed
    assert_alphabet dump
    assert_alphabet parsed.inspect
    assert_equal original, parsed
  end
  
  def assert_alphabet(obj)
    alphabet = ("b".."z").to_a.join('')
    found = obj.inspect.scan(/[a-z]/).flatten.join('')
    assert_equal alphabet, found
  end
  
  def create_random_hash
    h = OrderedHash.new
    s = "a"
    25.times do
      h[rand.to_s] = s.succ!.dup
    end
    h
  end
end
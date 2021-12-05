require "test_helper"

class StrategyTest < ActiveSupport::TestCase
  include StrategiesHelper
  test "Works on Simple Input" do
    json = {"rsi"=> {"coin"=> "Bitcoin", "value"=> "1", "condition"=> ">", "interval"=> "1d"}}
    expected = "(Bitcoin RSI > 1 on 1d)"
    actual = to_string(json)[0]
    assert_equal expected, actual
  end

  test "Works on Hard Input" do
    json = {"and"=>
      {"rsi"=>{"coin"=>"Bitcoin", "value"=>"1", "condition"=>">", "interval"=>"1d"},
       "or"=>
        {"rsi"=>{"coin"=>"Ethereum", "value"=>"1", "condition"=>"<", "interval"=>"1w"},
         "vwap"=>{"coin"=>"Litecoin", "value"=>"5", "condition"=>">", "interval"=>"1d"}},
       "not"=>
        {"macd"=>
          {"coin"=>"Ethereum",
           "valueMACD"=>{"value"=>"1", "condition"=>"<"},
           "valueMACDsignal"=>{"value"=>"2", "condition"=>">"},
           "valueMACDhist"=>{"value"=>"3", "condition"=>"<"},
           "interval"=>"1d"}}}}
    expected = "((Bitcoin RSI > 1 on 1d) AND ((Ethereum RSI < 1 on 1w) OR (Litecoin VWAP > 5 on 1d)) AND (NOT (Ethereum MACD valueMACD < 1, valueMACDsignal > 2, valueMACDhist < 3 on 1d)))"
    actual = to_string(json)[0]
    assert_equal expected, actual
  end
end
require "test_helper"

class StrategyTest < ActiveSupport::TestCase
  test "works" do
    input = 'hello there this is some text'
    word = 'he'
    expected= '<strong>he</strong>llo t<strong>he</strong>re this is some text'
    actual = AboutHelper.highlight_instances(input, word)
    assert expected == actual
  end
end

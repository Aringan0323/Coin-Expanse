require "test_helper"

class AboutTest < ActiveSupport::TestCase
  test "Works on Valid Input" do
    input = 'hello there this is some text'
    word = 'he'
    expected= '<mark>he</mark>llo t<mark>he</mark>re this is some text'
    actual = AboutHelper.highlight_instances(input, word)
    assert expected == actual
  end
end

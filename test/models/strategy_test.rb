require "test_helper"

class StrategyTest < ActiveSupport::TestCase
  test "valid strategy passes" do
    s = Strategy.new(side: 'BUY', amount: 1.0)
    assert s.valid?
  end

  test "invalid strategy fails" do
    s = Strategy.new
    assert !s.valid?
  end
end

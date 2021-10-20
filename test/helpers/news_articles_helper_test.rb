require "test_helper"
class NewsArticlesHelperTest < ActiveSupport::TestCase

	test "formats keywords correctly" do

		kws = ["bitcoin", "binance", "giraffes", "cryptocurrency", "leave this place now!"]
		expected_format = "bitcoin%20OR%20binance%20OR%20giraffes%20OR%20cryptocurrency%20OR%20leave%20this%20place%20now!"
		actual_format = NewsArticlesHelper.format_keywords(kws)
		assert_equal(expected_format, actual_format)

	end
end
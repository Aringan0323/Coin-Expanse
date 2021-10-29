require "./app/api_wrappers/market_api.rb"


namespace :update_coins do
  desc "updates all of the coins book tickers"
  task :update_btickers do
    btickers = MarketApi.book_tickers()
    btickers.each do |bticker|
      bticker.save
    end
  end
end

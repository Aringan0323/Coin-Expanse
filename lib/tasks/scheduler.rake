require "./app/api_wrappers/market_api.rb"

namespace :db do
  desc "updates all of the coins book tickers"
  task update_btickers: :environment do
    btickers = MarketApi.book_tickers(Coin.all)
    btickers.each do |bticker|
      bticker.save
    end
  end
end

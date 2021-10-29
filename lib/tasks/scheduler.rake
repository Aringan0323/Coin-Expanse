require "./app/api_wrappers/market_api.rb"

task :update_feed => :environment do
  btickers = MarketApi.book_tickers(Coin.all)
  btickers.each do |bticker|
    bticker.save
  end
end

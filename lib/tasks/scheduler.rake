require "./app/api_wrappers/market_api.rb"

namespace :db do
  desc "updates all of the coins book tickers"
  task update_btickers: :environment do
    600.times do 
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end
      puts "saved btickers"
      sleep(1.second)
    end
  end
end

# rake db:update_btickers

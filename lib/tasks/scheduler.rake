require "./app/api_wrappers/market_api.rb"
require "./app/api_wrappers/news_api.rb"
require "./app/helpers/coin_helper.rb"
ENV["NEWS_API_KEY"] = "af7ed64513f5449a855f235ca6484388"

namespace :db do
  desc "updates all of the coins book tickers each second"
  include CoinHelper
  task update_btickers_every_second: :environment do
    while true do
      BookTicker.where(['timestamp < ?', 8.hours.ago]).destroy_all
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end
      # Coin.all.each do |coin|
      #   broadcast_price_charts(coin)
      # end

      puts "saved btickers"
      sleep(1.second)
    end
  end

  desc "updates all of the coins book tickers every minute"
  task update_btickers_every_minute: :environment do
    while true do 
      BookTicker.where(['timestamp < ?', 24.hours.ago]).destroy_all
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end
      puts "saved btickers"
      sleep(1.minute)
    end
  end 

  desc "updates news articles"
  task update_news: :environment do
    puts "Deleting all news articles"
    NewsArticle.delete_all

    puts "Creating news articles"
    articles_list = NewsApi.all_articles(["crypto", "cryptocurrency", "blockchain", "bitcoin"])

    articles_list.each do |article|
        article.save
    end
  end
end

# rake db:update_btickers

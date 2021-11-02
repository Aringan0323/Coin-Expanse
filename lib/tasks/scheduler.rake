require "./app/api_wrappers/market_api.rb"
require "./app/api_wrappers/news_api.rb"
ENV["NEWS_API_KEY"] = "af7ed64513f5449a855f235ca6484388"

namespace :db do
  desc "updates all of the coins book tickers"
  task update_btickers: :environment do
    while true do  
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end
      puts "saved btickers"
      sleep(1.second)
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

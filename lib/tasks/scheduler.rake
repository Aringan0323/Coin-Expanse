require "./app/api_wrappers/market_api.rb"
require "./app/api_wrappers/news_api.rb"
require "./app/helpers/coin_helper.rb"
require "./lib/utils/strategy_interpreter.rb"
require "./app/api_wrappers/indicator_api.rb"
ENV["NEWS_API_KEY"] = "af7ed64513f5449a855f235ca6484388"

namespace :db do
  require "chartkick"

  desc "updates all of the coins book tickers each second"
  include CoinHelper

  task update_btickers_every_second: :environment do
    while true do
      BookTicker.where(['timestamp < ?', 5.minutes.ago]).destroy_all
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end
      # Coin.all.each do |coin|
      #   broadcast_coin(coin)
      # end

      puts "saved btickers"
      sleep(1.second)
    end
  end

  task refresh_tickers: :environment do
    while true do
      BookTicker.where(['timestamp < ?', 7.minutes.ago]).destroy_all
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end
      # Coin.all.each do |coin|
      #   broadcast_coin(coin)
      # end

      puts "saved btickers"
      sleep(5.seconds)
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

  desc "check the indicators"
  task update_indicators: :environment do 

    first = true
    while true
      indic_names = ["rsi", "stoch", "macd", "bbands2", "vwap"]
      Coin.all.each do |coin|
        ["1h", "1d", "1w"].each do |interval|
          if !first
            sleep(16.seconds)
          else
            first = false
          end
          indics = []
          indic_names.each do |indic_name|
            indics << Indicator.new(coin: coin, name: "#{coin.symbol}_#{indic_name}", interval: interval)
          end
          IndicatorApi.bulk(coin, interval, indics)
          indics.each do |indic|
            indic.save
          end
        end
      end
      puts "Created indicators"
    end
  end


end



namespace :strats do 

  desc "Runs all user strategies"

  task check_user_strategies: :environment do
    User.all.each do |user|
      StrategyInterpreter.check_strategies(user)
    end
  end

end


# rake db:update_btickers

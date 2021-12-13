require "sidekiq-scheduler"
class TickerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'
  def perform(*args)
    BookTicker.where(['timestamp < ?', 7.minutes.ago]).destroy_all
      btickers = MarketApi.book_tickers(Coin.all)
      btickers.each do |bticker|
        bticker.save
      end

      # puts "saved btickers"
  end
end

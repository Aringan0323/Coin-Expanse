require "./app/api_wrappers/indicator_api.rb"
require "sidekiq-scheduler"

class IndicatorWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  def perform(args)
    coin = args[:coin]
    interval = args[:interval]
    indics = coin.indicators.where(interval: interval)
    
    IndicatorApi.bulk(coin, interval, indics)
    10.times do 
      puts "Created #{coin.name} #{interval} indicators"
    end
  end

  # def perform(*args)
  #   first = true
  #   indic_names = ["rsi", "stoch", "macd", "bbands2", "vwap"]
  #   Coin.all.each do |coin|
  #     ["1h", "1d", "1w"].each do |interval|
  #       if !first
  #         sleep(16.seconds)
  #       else
  #         first = false
  #       end
  #       indics = []
  #       indic_names.each do |indic_name|
  #         indics << Indicator.new(coin: coin, name: "#{coin.symbol}_#{indic_name}", interval: interval)
  #       end
  #       IndicatorApi.bulk(coin, interval, indics)
  #       indics.each do |indic|
  #         old_indicator = Indicator.find_by(name: indic.name, interval: indic.interval)
  #         indic.save
  #         old_indicator.destroy
  #       end
  #     end
  #   end
  #   puts "Created indicators"
  # end
end

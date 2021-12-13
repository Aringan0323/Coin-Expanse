require "./app/api_wrappers/indicator_api.rb"
require "sidekiq-scheduler"

class IndicatorWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'
  def perform(args)
    coin = Coin.find(args[0])
    interval = args[1]
    indics = coin.indicators.where(interval: interval)
    
    IndicatorApi.bulk(coin, interval, indics)
    puts "Created #{coin.name} #{interval} indicators"
  end
end

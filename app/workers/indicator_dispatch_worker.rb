require "sidekiq-scheduler"
require "./app/workers/indicator_worker.rb"
class IndicatorDispatchWorker
    include Sidekiq::Worker
    def perform(*args)
        time_delay = 0
        coin_ids = Coin.all.pluck(:id)
        coin_ids.each do |coin_id|
            ["1h", "1d", "1w"].each do |interval|
                IndicatorWorker.perform_in(time_delay.seconds.from_now, [coin_id, interval])
                time_delay = time_delay + 20
            end
        end
    end


end
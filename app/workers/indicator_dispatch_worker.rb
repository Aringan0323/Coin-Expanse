require "sidekiq-scheduler"
require "./app/workers/indicator_worker.rb"
class IndicatorDispatchWorker
    include Sidekiq::Worker
    def perform(*args)
        time_delay = 0
        Coin.all.each do |coin|
            ["1h", "1d", "1w"].each do |interval|

                IndicatorWorker.perform_in(time_delay.seconds.from_now, [coin.id, interval])
                time_delay = time_delay + 20
            end
        end
    end


end
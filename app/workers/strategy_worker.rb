require "./lib/utils/strategy_interpreter.rb"
require "sidekiq-scheduler"
class StrategyWorker
  include Sidekiq::Worker

  def perform(*args)
    # User.all.each do |user|
    #   outcome = StrategyInterpreter.check_strategies(user)
    # end
    puts "checked strategies"
  end
end

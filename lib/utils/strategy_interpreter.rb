require "./app/api_wrappers/order_api.rb"


module StrategyInterpreter

    def check_strategies(user)
        user.strategies.all.each do |strat|
            strat = JSON.parse(strat.algorithm.gsub("=>", ":").gsub("nil", "null"))
            check_strategy(user, strat)
        end 
    end

    def check_strategy(user, strategy)

        

    end
end
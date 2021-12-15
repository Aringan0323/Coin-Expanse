require "./app/api_wrappers/order_api.rb"
require "httparty"
require "date"

module StrategyInterpreter

    def self.check_strategies(user)
        outcomes = []
        user.strategies.all.each do |strat|
            algorithm = JSON.parse(strat.algorithm.gsub("=>", ":"))
            side = strat.side
            coin = Coin.find_by(name: strat.coin_name)
            amount = strat.amount

            outcomes << check_strategy(user, algorithm, side, coin, amount, strat)
        end 
    end

    def self.check_strategy(user, algorithm, side, coin, amount, strat)
        res = nil
        if strat.enabled && self.check_and(algorithm)
            if side == "BUY"
                res = OrderApi.buy(user, coin, amount)
            else
                res = OrderApi.sell(user, coin, amount)
            end
        end

        if !res.nil? && res.success?
            strat.last_executed = DateTime.now()
            strat.save
        end
        return res
    end


    def self.check_and(and_hash)
        execute = true
        and_hash.keys.each do |key|
            if key == "and"
                execute = execute && self.check_and(and_hash[key])
            elsif key == "or"
                execute = execute && self.check_or(and_hash[key])
            elsif key == "not"
                not_indic = and_hash[key].keys[0]
                execute = execute && !self.check_indicator(not_indic, and_hash[key][not_indic])
            else
                execute = execute && self.check_indicator(key, and_hash[key])
            end
        end
        execute
    end

    def self.check_or(or_hash)
        execute = false
        or_hash.keys.each do |key|
            key = key.to_s
            if key == "and"
                execute = execute || self.check_and(or_hash[key])
            elsif key == "or"
                execute = execute || self.check_or(or_hash[key])
            elsif key == "not"
                not_indic = or_hash[key].keys[0]
                execute = execute || !self.check_indicator(not_indic, or_hash[key][not_indic])
            else
                execute = execute || self.check_indicator(key, or_hash[key])
            end
        end
        execute
    end

    def self.check_indicator(ind_name, ind_hash)
        coin = Coin.find_by(name: ind_hash['coin'])
        ind_name = coin.symbol + "_" + ind_name
        indicator = Indicator.find_by(name: ind_name, interval: ind_hash['interval'])
        data = JSON.parse(indicator.data.gsub("=>", ":"))
        execute = false
        if data.keys.count == 1
            execute = self.cond(ind_hash['value'], ind_hash['condition'], data[data.keys[0].to_s])
        else
            execute = true
            data.keys.each do |key|
                val = ind_hash[key.to_s]
                execute = execute && self.cond(val['value'], val['condition'], data[key.to_s])
            end
            execute
        end
        execute
    end

    def self.cond(expected, condition, actual)
        bool = false
        if condition == "<"
            bool = actual.to_f < expected.to_f
        elsif condition == ">"
            bool =  actual.to_f > expected.to_f
        else
            bool = false
        end
        bool
    end

end






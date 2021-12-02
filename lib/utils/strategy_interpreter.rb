require "./app/api_wrappers/order_api.rb"


module StrategyInterpreter

    def self.check_strategies(user)
        user.strategies.all.each do |strat|
            strat = JSON.parse(strat.algorithm.gsub("=>", ":").gsub("nil", "null"))
            check_strategy(user, strat)
        end 
    end

    def self.check_strategy(user, strategy)
        if self.check_and(strategy)
            #NOT YET IMPLEMENTED
            puts "EXECUTE ORDER"
        else
            puts "NO ORDER"
        end
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
        indicator = Indicator.find_by(name: "#{coin.symbol}_#{ind_name}", interval: ind_hash['interval'])
        data = JSON.parse(indicator.data.gsub("=>", ":"))
        execute = false
        if data.keys.count == 1
            execute = self.cond(ind_hash['value'], ind_hash['condition'], data[data.keys[0].to_s])
        else
            execute = true
            data.keys.each do |key|
                val = ind_hash[key]
                execute = execute && self.cond(val['value'], val['condition'], data[key])
            end
            execute
        end
        puts indicator.name + ": " + execute.to_s
        execute
    end

    def self.cond(expected, condition, actual)
        bool = false
        if condition == "<"
            bool = expected.to_f < actual.to_f
        elsif condition == ">"
            bool = expected.to_f > actual.to_f
        else
            bool = false
        end
        puts "#{expected} #{condition} #{actual} : #{bool}"
        bool
    end

end
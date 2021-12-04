require "./app/api_wrappers/order_api.rb"


module StrategyInterpreter

    def self.check_strategies(user)
        user.strategies.all.each do |strat|
            strat = JSON.parse(strat.algorithm.gsub("=>", ":"))
            side = strat.side
            coin = Coin.find_by(name: strat.coin_name)
            amount = strat.amount

            check_strategy(user, strat, side, coin, amount)
        end 
    end

    def self.check_strategy(user, strategy, side, coin, amount)
        if self.check_and(strategy)
            if side == "BUY"
                OrderApi.buy(user, coin, amount)
            else
                OrderApi.sell(user, coin, amount)
            end
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
                puts "Got here"
                execute = execute && self.check_indicator(key, and_hash[key])
                puts "Got further"
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
        puts ind_name
        indicator = Indicator.find_by(name: "#{coin.symbol}_#{ind_name}", interval: ind_hash['interval'])
        puts indicator.name
        data = JSON.parse(indicator.data.gsub("=>", ":"))
        execute = false
        if data.keys.count == 1
            execute = self.cond(ind_hash['value'], ind_hash['condition'], data[data.keys[0].to_s])
        else
            execute = true
            data.keys.each do |key|
                val = ind_hash[key.to_s]
                execute = execute && self.cond(val['value'], val['condition'], data[key.to_s]['value'])
            end
            execute
        end
        puts indicator.name + ": " + execute.to_s
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
        puts "#{actual} #{condition} #{expected}: #{bool}"
        bool
    end

end
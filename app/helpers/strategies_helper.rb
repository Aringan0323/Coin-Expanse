require "./lib/utils/strategy_interpreter.rb"

module StrategiesHelper

  include SessionsHelper

  def generate_coin_link(name)
    id = Coin.find_by(name: name).id
    "/coin/#{id}"
  end

  def generate_delete_link(strat)
    "/strategies/delete/#{strat.id}"
  end

  def generate_edit_link(strat)
    "/strategies/edit/#{strat.id}"
  end

  def generate_execute_link(strat)
    "/strategies/execute/#{strat.id}"
  end
  
  def generate_description(strat)
    "This strategy will #{strat.side.downcase} #{pluralize strat.amount, 'coin'} of #{strat.coin_name}"
  end

  def to_string_from_json(strat)
    alg = JSON.parse(strat.algorithm.gsub("=>", ":"))
    to_string alg
  end
  
  def to_string(alg)
    bin_operations = ['and', 'or']
    uni_operation = ['not']

    simple_indic = ['rsi', 'vwap']

    res = []
    alg.keys.each do |key|
      if bin_operations.include? key
        str = to_string(alg[key]).join " #{key.upcase} "
        res.push "(#{str})"
      elsif uni_operation.include? key
        str = to_string(alg[key])[0]
        res.push "(#{key.upcase} #{str})"
      elsif simple_indic.include? key
        res.push "(#{format_simple key, alg[key]})"
      else
        res.push "(#{format_hard key, alg[key]})"
      end
    end
    res
  end

  def calculate_price(coin, side, amount)
    conversion = coin.book_tickers[-1][side == 'BUY' ? :askPrice : :bidPrice]
    amount * conversion
  end

  private

  def format_simple(name, parts)
    "#{parts['coin']} #{name.upcase} #{parts['condition']} #{parts['value']} on #{parts['interval']}"
  end

  def format_hard(name, parts)
    coin = parts['coin']
    interval = parts['interval']
    "#{coin} #{name.upcase} #{children parts.except!("coin", "interval")} on #{interval}"
  end

  def children(children)
    res = []
    children.keys.each do |child|
      res.push "#{child} #{children[child]['condition']} #{children[child]['value']}"
    end
    res.join ", "
  end


  def display_last_executed(le)
    puts "Never Executed: #{le.nil?}"
    if le.nil?
      "never"
    else
      le.localtime.strftime("%m/%d/%Y %I:%M %p")
    end
  end

end
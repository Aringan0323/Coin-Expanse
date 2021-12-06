require "./app/api_wrappers/api_utils.rb"
require "json"


module IndicatorApi

  '''
  Commonly used indicators:

  Relative Strength Index:                rsi
  Stochastic Oscillator:                  stoch
  Moving Average Convergence Divergence:  macd
  Bollinger Bands:                        bbands2
  Volume Weighted Average Price:          vwap
  
  '''

  def self.rsi(coin, interval)
    self.indicator("rsi", coin, interval)
  end

  def self.stochastic_oscillator(coin, interval)
    self.indicator("stoch", coin, interval)
  end

  def self.bbands(coin, interval)
    self.indicator("bbands2", coin, interval)
  end

  def self.bulk(coin, interval, indicators_list)
    indicator_names = []
    indicators_list.each do |ind|
      indicator_names << {indicator: ind.name.split("_")[1]}
    end
    construct = {
      exchange: "binance",
      symbol: "#{coin.symbol}/USDT",
      interval: interval,
      indicators: indicator_names
    }
    body = {secret: ENV["TAAPI_API_KEY"], construct: construct}
    response = ApiUtils.post_api_res("https://api.taapi.io/bulk", body)
    if !response.key?("error")
      data = response["data"]
      i = 0
      data.each do |indicator_data|
        if indicator_data["errors"].count == 0
          q_ind = indicators_list[i]
          q_ind.data = indicator_data["result"].to_s
          q_ind.save
        end
        i += 1
      end
    end

  end

  private

  def self.indicator(indicator, coin, interval)
    ApiUtils.get_api_res("https://api.taapi.io/#{indicator}?secret=#{ENV["TAAPI_API_KEY"]}&exchange=binance&symbol=#{coin.symbol}/USDT&interval=#{interval}")
  end


  

end
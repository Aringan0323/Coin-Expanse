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
    indicators = []
    indicators_list.each do |i|
      indicators << {indicator: i}
    end
    construct = {
      exchange: "binance",
      symbol: "#{coin.symbol}/USDT",
      interval: interval,
      indicators: indicators
    }
    body = {secret: ENV["TAAPI_API_KEY"], construct: construct}
    ApiUtils.post_api_res("https://api.taapi.io/bulk", body)

  end

  private

  def self.indicator(indicator, coin, interval)
    ApiUtils.get_api_res("https://api.taapi.io/#{indicator}?secret=#{ENV["TAAPI_API_KEY"]}&exchange=binance&symbol=#{coin.symbol}/USDT&interval=#{interval}")
  end


  

end
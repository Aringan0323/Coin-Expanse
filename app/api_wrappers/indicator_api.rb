require "./app/api_wrappers/api_utils.rb"
module IndicatorApi


  def self.rsi(coin, interval)
    self.indicator("rsi", coin, interval)
  end

  def self.stochastic_oscillator(coin, interval)
    self.indicator("stoch", coin, interval)
  end

  def self.bbands(coin, interval)
    self.indicator("bbands2", coin, interval)
  end

  private

  def self.indicator(indicator, coin, interval)
    ApiUtils.get_api_res("https://api.taapi.io/#{indicator}?secret=#{ENV["TAAPI_API_KEY"]}&exchange=binance&symbol=#{coin.symbol}/USDT&interval=#{interval}")
  end

end
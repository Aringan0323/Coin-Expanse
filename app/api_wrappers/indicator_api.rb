require "./app/api_wrappers/api_utils.rb"
module IndicatorApi

  def self.rsi(coin, interval)
    api_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFkYW1yaW5nQGJyYW5kZWlzLmVkdSIsImlhdCI6MTYzNTUzOTAyNCwiZXhwIjo3OTQyNzM5MDI0fQ.yJTKVpk9ki71pIzHua0OLb9JdHIAyXbQzcHzWBulAoE"

    json = ApiUtils.get_api_res("https://api.taapi.io/rsi?secret=#{api_key}&exchange=binance&symbol=#{coin.symbol}/USDT&interval=#{interval}")
    json["value"]
  end
end
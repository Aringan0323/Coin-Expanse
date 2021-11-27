
after :coins do
    Coin.all.each do |coin|
        Indicator.create(coin: coin, name: "rsi", data: "{}")
        Indicator.create(coin: coin, name: "stoch", data: "{}")
        Indicator.create(coin: coin, name: "macd", data: "{}")
        Indicator.create(coin: coin, name: "bbands2", data: "{}")
        Indicator.create(coin: coin, name: "vwap", data: "{}")
    end
end
puts "Created indicators"
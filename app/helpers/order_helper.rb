module OrderHelper
  def createData
    hash = {}
    Coin.all.each do |coin|
      hash[coin.name] = {}
      tickers = coin.book_tickers[-1]
      hash[coin.name][:ask] = tickers[:askPrice]
      hash[coin.name][:bid] = tickers[:bidPrice] 
    end
    hash.to_json
  end
end
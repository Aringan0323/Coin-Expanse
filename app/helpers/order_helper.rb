module OrderHelper
  def createData
    Coin.includes(:book_tickers).pluck(:book_tickers)[-4..-1].map { |ticker|
      ticker[1..-2].split(',').select.with_index { |e, i| e if [3, 5].include? i }
    }
  end
end
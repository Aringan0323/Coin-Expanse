module ApplicationHelper

  def safe_user?
    user = current_user
    pub = user.binance_public_key
    priv = user.encryptedBinanceApiKey
    pub && priv && pub != '' && priv != ''
  end

end

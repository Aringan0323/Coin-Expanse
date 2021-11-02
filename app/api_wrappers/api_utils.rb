require "net/http"
require "uri"

module ApiUtils

  # Accepts a GET request string and then returns a hash of the response from the Binance api, or nil if
  # the request failed
  def self.get_api_res(get_request)
    uri = URI(get_request)
    res = Net::HTTP.get_response(uri)

    if res.is_a?(Net::HTTPSuccess)
      JSON(res.body)
    else
      nil
    end
  end

end

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

  def self.post_api_res(post_request, body)
    uri = URI.parse(post_request)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|

      request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
      request.body = body.to_json

      JSON(http.request(request).body)
    end
  rescue => e
    puts "failed #{e}"
  end


end

module NewsArticlesHelper

  # def self.init_api_key(api_key)
  #   @key = api_key
  # end




  # def self.get_headlines(country, *keywords)


  # https://newsapi.org/v2/everything?q=bitcoin&apiKey=

  

  def self.format_keywords(keyword_list)

    keyword_string = keyword_list[0]


    (1..keyword_list.count-1).each do |i|

      keyword_string = keyword_string + " OR " + keyword_list[i]
    end

    keyword_string.gsub!(" ", "%20")

    keyword_string
  end

end

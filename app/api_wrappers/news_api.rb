module NewsApi

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


  # t.string "title"
  # t.string "name"
  # t.string "description"
  # t.string "url"
  # t.string "image_url"
  # t.date "date"


  # def all_articles(keyword_list)
  #   https://newsapi.org/v2/everything?q=bitcoin&apiKey=af7ed64513f5449a855f235ca6484388



end
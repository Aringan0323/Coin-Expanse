require "./app/api_wrappers/api_utils.rb"


module NewsApi
  
  def self.format_keywords(keyword_list)
  
    keyword_string = keyword_list[0]

    (1..keyword_list.count-1).each do |i|
      keyword_string = keyword_string + " OR " + keyword_list[i]
    end

    keyword_string.gsub!(" ", "%20")
    keyword_string
  end


  def self.create_articles(articles_hash)

    articles_list = []

    articles_hash.each do |article_hash|
      article = NewsArticle.new
      article.title = article_hash["title"]
      article.name = article_hash["source"]["name"]
      article.description = article_hash["description"]
      article.url = article_hash["url"]
      article.image_url = article_hash["urlToImage"]
      article.date = DateTime.parse(article_hash["publishedAt"])

      articles_list << article
    end

    articles_list
  end

  def self.all_articles(keyword_list)
    keyword_params = format_keywords(keyword_list)
    oldest = DateTime.now() - 3
    oldest = oldest.strftime("%Y-%m-%d")
    puts oldest
    response = ApiUtils.get_api_res("https://newsapi.org/v2/everything?q=#{keyword_params}&from=#{oldest}&language=en&apiKey=af7ed64513f5449a855f235ca6484388")
    if response.nil?
      nil
    else
      articles_hash = response["articles"]
      articles = create_articles(articles_hash)
      articles
    end
  end




end
require "./app/api_wrappers/news_api"
ENV["NEWS_API_KEY"] = "af7ed64513f5449a855f235ca6484388"
puts "Deleting all news articles"
NewsArticle.delete_all

puts "Creating news articles"
articles_list = NewsApi.all_articles(["crypto", "cryptocurrency", "blockchain", "bitcoin"])

articles_list.each do |article|
    article.save
end

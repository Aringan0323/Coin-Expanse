require "./app/api_wrappers/news_api.rb"
require "sidekiq-scheduler"
class NewsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'
  def perform(*args)
    puts "Deleting all news articles"
    NewsArticle.delete_all

    puts "Creating news articles"
    articles_list = NewsApi.all_articles(["crypto", "cryptocurrency", "blockchain", "bitcoin"])

    articles_list.each do |article|
        article.save
    end
  end
end

class HomeController < PublicController

  def index
    @news =  NewsArticle.order(date: :desc).limit(12)
  end

end
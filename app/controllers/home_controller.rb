class HomeController < PrivateController

  def index
    @news =  NewsArticle.order('RANDOM()').limit(6)
  end

end
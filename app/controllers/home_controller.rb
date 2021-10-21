class HomeController < ApplicationController

  def index
    @news =  NewsArticle.order('RANDOM()').limit(6)
  end

end
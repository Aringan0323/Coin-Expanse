require './app/helpers/about_helper'

class AboutController < ApplicationController
  def index
    search_terms = params[:search_param]
    file = File.open('./app/views/about/data/data.txt')
    about = file.read
    if search_terms && !search_terms.empty?
      about = AboutHelper.highlight_instances about, search_terms
    end
    @about = about
  end
end

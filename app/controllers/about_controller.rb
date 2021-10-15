class AboutController < ApplicationController
  def index
    search_terms = params[:search_param]
    file = File.open('./app/views/about/data/data.txt')
    about = file.read
    if search_terms
      search_terms = search_terms.downcase
      relative = about.downcase
      location = relative.index(search_terms)
      relative = "#{relative[0 , location]}<mark>#{about[location, location + search_terms.size]}</mark>#{relative[location + search_terms.size..-1]}"
      puts relative
    end
    @about = about
  end
end

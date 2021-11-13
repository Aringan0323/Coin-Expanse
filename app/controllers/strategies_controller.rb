class StrategiesController < PrivateController
  def new
    @operations = params[:total] ? params[:total].prepend(params[:operation]) : []
  end
  def show; end
end
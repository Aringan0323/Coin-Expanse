class StrategiesController < PrivateController
  def new; end
  def show; end
  def add_card
    respond_to do |format|
      format.js
    end
  end
end

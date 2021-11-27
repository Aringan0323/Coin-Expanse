class StrategiesController < PrivateController
  def new; end
  def create
    redirect_to "/strategies/library"
  end
  def add_card
    respond_to do |format|
      format.js
    end
  end
end

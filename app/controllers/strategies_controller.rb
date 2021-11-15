class StrategiesController < PrivateController
  def new
    respond_to do |format|
      format.html { render :action => 'new' }
      format.js { render :action => 'new' }
    end
  end
  def show; end
end
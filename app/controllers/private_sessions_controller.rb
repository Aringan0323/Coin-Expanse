class PrivateSessionsController < PrivateController
  def destroy
    log_out
    redirect_to '/login'
  end
end
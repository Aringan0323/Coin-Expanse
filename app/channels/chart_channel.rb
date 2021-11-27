class ChartChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:symbol]}_chart"
  end

end

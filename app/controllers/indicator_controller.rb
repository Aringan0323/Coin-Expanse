class IndicatorController < ApplicationController

    def get_data
        name = params[:name].to_s
        interval = params[:interval].to_s
        indicator = Indicator.find_by(name: name, interval: interval)
        data = []
        ind_data = JSON.parse(indicator.data.gsub("=>", ":"))
        ind_data.keys.each do |key|
          data << {name: key, data: ind_data[key].to_f}
        end
        puts data
        render json: data.to_json
    end
end

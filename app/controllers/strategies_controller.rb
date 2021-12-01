class StrategiesController < PrivateController
  def new; end

  def create
    if !params['data']['content']
      flash[:danger] = 'Unrecognized strategy format'
      redirect_to '/strategies/new'
    else
      filtered_json = filter_json(params['data']['content']['0'])
      puts "here is solution:"
      pp filtered_json
      strat = Strategy.new(algorithm: filtered_json.to_s)
      current_user.strategies << strat
      strat.save
      pp filtered_json
      # other logic here
      redirect_to '/strategies/library'
    end
  end

  def add_card
    respond_to do |format|
      format.js
    end
  end

  private

  def filter_json(json)
    res = {}
    if json['type'] == 'DIV'
      if json['attributes']['id']
        id = json['attributes']['id']
        name = id[..id.index('-') - 1]
        res[name] = {}
        json['content']['0']['content'].each do |_key, child|
          res[name].merge!(filter_json(child))
        end
      elsif json['attributes']['class'] == 'input-row'
        content = json['content']
        name = content['0']['content']['0']['attributes']['id']
        res[name] = { 'value' => content['0']['content']['0']['attributes']['value'],
                      'condition' => content['1']['attributes']['value'] } # is a row of value and error
      else
        content = json['content']
        name = content['0']['attributes']['id']
        res[name] = content['0']['attributes']['value']
      end
    elsif json['type'] == 'SELECT'
      data = json['attributes']
      res[data['id']] = data['value']
    end
    res
  end


end

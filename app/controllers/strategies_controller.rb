class StrategiesController < PrivateController
  def new; end

  def edit
    strategy = Strategy.find(params[:id])
    @raw = strategy.raw
    @name = strategy.name
    @qty = strategy.amount
    @side = strategy.side
  end

  def create
    if !params['data']['content']
      flash[:danger] = 'Unrecognized strategy format'
      redirect_to '/strategies/new'
    else
      filtered_json = filter_json(params['data']['content']['0'])
      pp filtered_json
      strat = Strategy.new(name: params[:name], side: params[:type], coin_name: params[:coin], amount: params[:quantity], algorithm: filtered_json.to_json, raw: params[:html_raw])
      current_user.strategies << strat
      if strat.save
        redirect_to '/strategies/library'
      else
        flash[:danger] = 'Please fill out all required fields'
        redirect_to '/strategies/new'
      end
    end
  end

  def show
    @strategies = current_user.strategies
  end

  def add_card
    respond_to do |format|
      format.js
    end
  end

  def delete
    strat = Strategy.find(params[:id])
    if strat.delete
      flash[:success] = "Successfully deleted"
      redirect_to '/strategies/library'
    else
      flash[:danger] = "Something went wrong"
      redirect_to '/strategies/library'
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

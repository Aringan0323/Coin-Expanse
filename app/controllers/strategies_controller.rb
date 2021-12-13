require "./lib/utils/strategy_interpreter.rb"
require "httparty"

class StrategiesController < PrivateController
  def new
    @raw = params[:raw_html] || nil
  end

  def edit
    strategy = Strategy.find(params[:id])
    @raw = strategy.raw
    @name = strategy.name
    @for = strategy.coin_name
    @qty = strategy.amount
    @side = strategy.side
    @id = params[:id]
  end

  def update
    strategy = Strategy.find(params[:id])
    filtered_json = filter_json(params['data']['content']['0'])
    pp filtered_json
    if strategy.update(name: params[:name], side: params[:type], coin_name: params[:coin], amount: params[:quantity], algorithm: filtered_json.to_json, raw: params[:html_raw])
      flash[:success] = "#{strategy.name} successfully updated"
    else
      flash[:danger] = "Not able to update #{strategy.name}"
    end
    redirect_to '/strategies/library'
  end

  def create
    pp params
    if !params['data']['content']
      flash[:danger] = 'Unrecognized strategy format'
      redirect_to '/strategies/new'
    else
      begin
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
      rescue => exception
        puts exception
        flash[:danger] = "#{exception}"
        redirect_to controller: 'strategies', action: 'new', raw_html: params[:html_raw]
      end
    end
  end

  def manual_execute
    strat = Strategy.find(params[:id])
    user = User.find(strat.user_id)
    algorithm = JSON.parse(strat.algorithm.gsub("=>", ":"))
    side = strat.side
    coin = Coin.find_by(name: strat.coin_name)
    amount = strat.amount
    response = StrategyInterpreter.check_strategy(user, algorithm, side, coin, amount)
    puts response
    puts response.class
    if response == nil
      flash[:danger] = "Your strategy did not execute a trade"
    elsif response.success?
      flash[:success] = "You successfully #{side_string} #{qty} #{qty == 1 ? 'coin' : 'coins'} of #{coin.name}"
      redirect_to '/order'
    else
      flash[:danger] = JSON.parse(response.body)['msg']
    end
    redirect_to '/strategies/library'
  end

  def show

    @strategies = current_user.strategies
    @orders = current_user.orders
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

  def execute
    JSON.parse(strat.algorithm.gsub("=>", ":"))
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
        unless content['0']['content']['0']['attributes']['value'] && content['1']['attributes']['value']
          raise "Missing subdata field for an indicator"
        end
        res[name] = { 'value' => content['0']['content']['0']['attributes']['value'],
                      'condition' => content['1']['attributes']['value'] } # is a row of value and error
      else
        content = json['content']
        name = content['0']['attributes']['id']
        res[name] = content['0']['attributes']['value']
      end
    elsif json['type'] == 'SELECT'
      data = json['attributes']
      unless data['value']
        raise "Error: #{data['id']} not set in one or more of the cards"
      end
      res[data['id']] = data['value']
    end
    res
  end


end

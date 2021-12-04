module StrategiesHelper
  def generate_coin_link(name)
    id = Coin.find_by(name: name).id
    "/coin/#{id}"
  end

  def generate_delete_link(strat)
    "/strategies/delete/#{strat.id}"
  end

  def generate_edit_link(strat)
    "/strategies/edit/#{strat.id}"
  end
end
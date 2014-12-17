class Api::V1::BattlefieldsController < ApplicationController

  def place_land
    Pusher['test_channel'].trigger("place_land#{params[:user_id]}", {
      card: params[:card]
    })
  end

  def cast_spell
    Pusher['test_channel'].trigger("cast_spell#{params[:user_id]}", {
      card: params[:card]
    })
  end

  def resolve_permanent
    Pusher['test_channel'].trigger("resolve_permanent#{params[:user_id]}", {
      card: params[:card]
    })
  end

  def resolve_nonpermanent
    Pusher['test_channel'].trigger("resolve_nonpermanent#{params[:user_id]}", {
      card: params[:card]
    })
  end

  def tap_card
    Pusher['test_channel'].trigger("tap_card#{params[:user_id]}", {
      card: params[:card]
    })
  end

  def opponent_draw
    Pusher['test_channel'].trigger("opponent_draw#{params[:user_id]}", {

    })
  end

  def send_land_to_graveyard
    Pusher['test_channel'].trigger("send_land_to_graveyard#{params[:user_id]}", {
      card: params[:card]
    })
  end

  def decrease_opponent_life
    Pusher['test_channel'].trigger("decrease_opponent_life#{params[:user_id]}", {

    })
  end

  def send_permanent_to_graveyard
    Pusher['test_channel'].trigger("send_permanent_to_graveyard#{params[:user_id]}", {
      card: params[:card]
    })
  end
end

class Api::V1::BattlefieldsController < ApplicationController

  def place_land
    # save gameplay here
    Pusher['test_channel'].trigger("place_land#{params[:user_id]}", {
      card: params[:card]
    })
  end

  
end

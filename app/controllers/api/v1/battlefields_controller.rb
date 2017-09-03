# frozen_string_literal: true

module Api
  module V1
    # API controller for battlefield operations.
    class BattlefieldsController < ApplicationController
      def place_land
        push_event('place_land', card: params[:card])
      end

      def cast_spell
        push_event('cast_spell', card: params[:card])
      end

      def resolve_permanent
        push_event('resolve_permanent', card: params[:card])
      end

      def resolve_nonpermanent
        push_event('resolve_nonpermanent', card: params[:card])
      end

      def tap_card
        push_event('tap_card', card: params[:card])
      end

      def opponent_draw
        push_event('opponent_draw', {})
      end

      def send_land_to_graveyard
        push_event('send_land_to_graveyard', card: params[:card])
      end

      def decrease_opponent_life
        push_event('decrease_opponent_life', {})
      end

      def send_permanent_to_graveyard
        push_event('send_permanent_to_graveyard', card: params[:card])
      end

      private

      def push_event(event_name, card)
        Pusher['test_channel'].trigger("#{event_name}#{params[:user_id]}", card)
      end
    end
  end
end

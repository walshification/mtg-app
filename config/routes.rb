Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root 'decks#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  resources :decks
  resources :cards

  namespace :api do
    namespace :v1 do
      resources :decks
      resources :cards
      post "place_land" => 'battlefields#place_land'
      post "cast_spell" => 'battlefields#cast_spell'
      post "resolve_permanent" => 'battlefields#resolve_permanent'
      post "resolve_nonpermanent" => 'battlefields#resolve_nonpermanent'
      post "tap_card" => 'battlefields#tap_card'
      post "opponent_draw" => 'battlefields#opponent_draw'
      post "send_land_to_graveyard" => 'battlefields#send_land_to_graveyard'
      post "send_permanent_to_graveyard" => 'battlefields#send_permanent_to_graveyard'
      post "decrease_opponent_life" => 'battlefields#decrease_opponent_life'
    end
  end

  get 'battlefield' => 'decks#battlefield', as: :battlefield
  get 'test' => 'decks#test_pusher'
end

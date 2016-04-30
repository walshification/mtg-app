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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

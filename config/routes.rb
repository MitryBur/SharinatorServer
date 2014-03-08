SharinatorServer::Application.routes.draw do

	namespace :v1 do

    resources :events, except: [:new, :edit], defaults: {format: :json}
    #do
    #  resources :expenses, except: [:new, :edit], defaults: {format: :json}
    #end

		resources :social_profiles, except: [:new, :edit], defaults: {format: :json}

    resources :users, except: [:new, :edit], defaults: {format: :json}

    resources :debts, except: [:new, :edit], defaults: {format: :json}

    resources :expenses, except: [:new, :edit], defaults: {format: :json}


    get 'vk', to: 'vk#authenticate'
    get 'vk/friends', to: 'vk#get_friends'
    get 'vk/index', to: 'vk#index'
    get 'vk/get_token', to: 'vk#get_access_token'

  end

  root 'welcome#main'

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

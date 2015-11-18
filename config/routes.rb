Rails.application.routes.draw do

  match '/success' => 'receiver#success', via: :post
  match '/failure' => 'receiver#failure', via: :post
  match '/ios_success' => 'receiver#ios_success', via: :post
  match '/ios_failure' => 'receiver#ios_failure', via: :post
  match '/get_hash' => 'receiver#get_hash', via: :post

  match '/get_merchant_hashes' => 'one_click_payment_hash#get_merchant_hashes', via: :post
  match '/store_merchant_hash' => 'one_click_payment_hash#store_merchant_hash', via: :post
  match '/delete_merchant_hash' => 'one_click_payment_hash#delete_merchant_hash', via: :post

  match '/ios_test_success' => 'receiver#ios_test_success', via: :post


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

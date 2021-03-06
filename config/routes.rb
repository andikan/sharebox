Sharebox::Application.routes.draw do
  resources :folders

  resources :assets

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks" }

  #this route is for file downloads  
  match "assets/get/:id" => "assets#get", :as => "download", via: [:get, :post]

  match "browse/:folder_id" => "home#browse", :as => "browse", via: [:get, :post]

  match "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder", via: [:get, :post]

  match "browse/:folder_id/new_file" => "assets#new", :as => "new_sub_file", via: [:get, :post]

  match "browse/:folder_id/rename" => "folders#edit", :as => "rename_folder", via: [:get, :post]

  # for sharing the folder
  match "home/share" => "home#share", via: [:get, :post]

  # api
  namespace :api do
    get "ping", to: "home#ping"

    scope 'users' do
      get "self", to: "users#self"
    end

    resources :files, controller: 'assets'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

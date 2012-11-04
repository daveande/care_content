CareContent::Application.routes.draw do
  root :to => 'pages#home'
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :users do
    resources :purchases, :only => [:new, :index, :create]
    put '/current_purchase' => 'purchases#current_purchase'
  end

  as :admin_user do 
    get '/admin_download_file' => 'admin/content_files#admin_download_file'
  end
   
  get '/about' => "pages#about"
  get '/terms' => "pages#terms"
  get '/unconfirmed_purchase' => 'pages#unconfirmed_purchase'
  post '/submit_unconfirmed_purchase' => 'pages#submit_unconfirmed_purchase'
  post '/suggestions' => "pages#suggestions"
  post '/contact' => "pages#contact"
  post '/send_sample' => "pages#send_sample"
  resources :content_files, :only => [:index, :show] do
    resources :downloads, :only => :create
  end
  resources :plans, :only => :index

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

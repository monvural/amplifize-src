Salon::Application.routes.draw do
  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout

  match '/reader/:view' => 'users#reader'
  match '/reader/people' => 'users#reader', :as => :people
  match '/reader' => 'users#reader', :as => :reader
  match '/unsubscribe/:feed_id' => 'users#unsubscribe', :as => :unsubscribe
  
  match '/users/search' => 'users#search', :as => :user_search

  match '/profile' => 'users#profile', :as => :profile
  match '/profile/update' => 'users#update', :as => :update_profile

  match '/feeds/import' => 'feeds#import', :as => :import
  match '/feeds/manage' => 'feeds#manage'


  match '/post_users(/:feed_id)/mark_all_read(/:state)', :controller => 'post_users', :action => 'mark_all_read'
  match '/post_users/:post_id/read_state/:state', :controller => 'post_users', :action => 'set_read_state'
  match '/share_users/:share_id/read_state/:state', :controller => 'share_users', :action => 'set_read_state'

  #follows actions
  match '/follows/add/:user_id' => 'follows#add', :as => :follows_add
  match '/follows/import/google' => 'follows#googleImport'

  #share actions
  match '/shares/add/' => 'shares#add', :as => :shares_add

  match '/about' => 'home#about', :as => :about
  match '/contact' => 'home#contact', :as => :contact
  match '/terms' => 'home#terms', :as => :terms
  match '/faq' => 'home#faq', :as => :faq

  resources :users, :user_sessions, :feeds, :posts, :shares, :comments, :tags

  root :to => "home#index"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

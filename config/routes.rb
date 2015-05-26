Rails.application.routes.draw do
  devise_scope :user do
    get 'user/:id', to: 'users#profile', as: 'profile'
    get 'user/:id/edit', to: 'users#edit', as: 'edit_profile'
    get 'user/:id/:filter', to: 'users#profile', as: 'profile_filter'
    post 'user/:id/follow', to: 'users#follow', as: 'follow'
    post 'user/:id/unfollow', to: 'users#unfollow', as: 'unfollow'
    put 'user/:id/avatar', to: 'users#upload_avatar', as: 'avatar'
    put 'user/:id', to: 'users#update', as: 'update_profile'
    post 'users', to: 'users#create', as: 'register_user'
    get '/' => "home#index", :as => :login
  end

  devise_for :users, :controllers => {:registrations => "users"}
  resources :posts do
    resource :comments
    post 'comments/reply', to: 'comments#reply', as: 'comment_reply'
  end

  put 'posts/:id/upvote', to: 'posts#upvote'
  put 'posts/:id/downvote', to: 'posts#downvote'


  post 'category/:category_id/subscribe', to: 'category#subscribe', as: 'subscribe'
  post 'category/:category_id/unsubscribe', to: 'category#unsubscribe', as: 'unsubscribe'

  scope '/c' do
    get ':category(/:filter)', to: 'home#index', as: 'category_filter'
  end

  get ':filter', to: 'home#index', as: 'filter'
  root 'home#index'

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

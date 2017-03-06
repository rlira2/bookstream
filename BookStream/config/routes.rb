Rails.application.routes.draw do
  resources :tags
  devise_for :users, controllers: {registrations: 'users/registrations'}

  resources :books, except: :index
  resources :tags, except: :show

  get '/books/:id/read/:page(.:format)' => 'books#read', as: 'read'
  root 'pages#main'
  get 'home' => 'pages#home'
  get 'adm_users' => 'pages#adm_users'
  get 'error' => 'pages#error'
  get 'private' => 'pages#private'
  get 'delete_user' => 'pages#delete_user'
  get 'feedback' => 'pages#feedback'

  get '/books/:id/send_book' => 'books#email_book', as: 'email_book'

  get 'publiclib' => 'pages#publiclib'

  patch 'books/:id/convert(.:format)' => 'books#convert', as: 'convert'
  patch 'books/:id/add_tag(.:format)' => 'books#add_tag', as: 'add_tag'
  patch 'books/:id/remove_tag(.:format)' => 'books#remove_tag', as: 'remove_tag'
  post 'books/:id(.:format)' => 'books#add_book', as: 'add_book'

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

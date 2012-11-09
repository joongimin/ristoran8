Ristoran8::Application.routes.draw do
  devise_for :users, :controllers => {
    :sessions => "users/sessions",
  }

  resources :users

  resources :orders do
    collection do
      put "complete"
    end

    member do
      put "confirm"
    end
  end

  resources :sub_orders, :only => :create do
    member do
      put "increment"
      put "decrement"
    end
  end

  resources :images

  resources :restaurants do
    resources :menu_categories, :only => [:show, :new, :edit] do
      resources :menu_items, :only => [:show, :new, :edit]
    end
    resources :tables, :only => [:new, :edit] do
      member do
        put "login_as_table"
      end
    end
  end

  resources :menu_categories, :except => [:show, :new, :edit]
  resources :menu_items, :except => [:show, :new, :edit]
  resources :tables, :except => [:show, :new, :edit, :index]

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
  root :to => 'restaurants#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

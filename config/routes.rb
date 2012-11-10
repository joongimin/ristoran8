Ristoran8::Application.routes.draw do
  resources :advertisements, :except => [:index]

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
  root :to => 'restaurants#index'

  namespace :api do
    namespace :v1 do
      resources :users, :only => [] do
        collection do
          post "login"
          post "logout"
          post "login_with_token"
          post "create"
        end
      end

      resources :restaurants, :only => [:index, :show] do
        resources :tables, :only => [:create] do
          member do
            put "login_as_table"
          end
        end
      end

      resources :orders, :only => [:index] do
        collection do
          put "complete"
        end

        member do
          put "confirm"
        end
      end

      resources :sub_orders, :only => [:create] do
        member do
          put "increment"
          put "decrement"
        end
      end
    end
  end
end

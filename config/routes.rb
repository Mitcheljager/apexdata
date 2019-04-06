Rails.application.routes.draw do
  mount Flipper::UI.app(Flipper) => "/flipper"
  
  root "high_voltage/pages#show", id: "index"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :profiles, only: [:index]
  get "profile/:platform/:user", to: "profiles#show"

  get "register", to: "users#new", as: "register"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  get "compare/:first/:second" => "compare#index", as: "compare"
  get "where/:where/:value" => "where#index", as: "where"

  get "viewtype/expanded" => "viewtype#expanded", as: "expanded"
  get "viewtype/compact" => "viewtype#compact", as: "compact"

  get "legends" => "legends#index"
  get "legends/:name" => "legends#show", as: "legend_show"

  get "sort/:items/:sort_by" => "sort#index", as: "sort"
end

Rails.application.routes.draw do
  if Rails.env.development?
    mount Flipper::UI.app(Flipper) => "/flipper"
  end

  mount ActionCable.server => "/cable"

  root "high_voltage/pages#show", id: "index"

  resources :users, only: [:new, :create, :destroy]
  get "user/edit", to: "users#edit", as: "edit_user"
  get "user", to: "users#show", as: "account"
  patch "user", to: "users#update", as: "update_user"
  delete "user", to: "users#destroy", as: "destroy_user"

  resources :sessions, only: [:new, :create, :destroy]

  get "register", to: "users#new", as: "register"
  get "login", to: "sessions#new", as: "login"
  get "logout", to: "sessions#destroy", as: "logout"

  get "where/:where/:value", to: "where#index", as: "where"

  get "legends", to: "legends#index"
  get "legends/:name", to: "legends#show", as: "legend_show"

  get "sort/:items/:sort_by", to: "sort#index", as: "sort"

  scope :api do
    get ":key/:type", to: "api#basic"
    get ":key/:type/:where/:value", to: "api#where"
    get ":key/:type/sort/:items/:sort_by", to: "api#sort"
    get ":key/:type/:category", to: "api#category"
  end

  resources :memberships, only: [:new, :create, :update]

  resources :notifications, only: [:create, :update]
  get "show_notifications", to: "notifications#show", as: "show_notifications"
end

Rails.application.routes.draw do
  if Rails.env.development?
    mount Flipper::UI.app(Flipper) => "/flipper"
  end

  root "high_voltage/pages#show", id: "index"

  resources :users, only: [:index, :new, :create, :destroy]
  get "user/edit", to: "users#edit", as: "edit_user"
  get "user", to: "users#show", as: "account"
  patch "user", to: "users#update", as: "update_user"
  delete "user", to: "users#destroy", as: "destroy_user"

  resources :sessions, only: [:new, :create, :destroy]

  get "tracker", to: "profiles#index", as: "tracker"
  get "profile/:platform/:user", to: "profiles#show", as: "profile"
  get "profile/:platform/:user/charts(/:start_date)(/:end_date)(/:limit)", to: "profiles#charts", as: "profile_charts"

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

  resources :claimed_profiles, only: [:index, :destroy]
  post "claim-initiate", to: "claimed_profiles#initiate", as: "claim_profile_initiate"
  post "claim-step-1", to: "claimed_profiles#step_1", as: "claim_profile_step_1"
  post "claim-step-2", to: "claimed_profiles#step_2", as: "claim_profile_step_2"
  post "claim-step-3", to: "claimed_profiles#step_3", as: "claim_profile_step_3"

  resources :memberships, only: [:index, :new, :create, :update]

  resources :events
  resources :event_signups, only: [:create, :update, :destroy]
end

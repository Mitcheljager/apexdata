Rails.application.routes.draw do
  root "high_voltage/pages#show", id: "index"

  get "compare/:first/:second" => "compare#index", as: "compare"
  get "where/:where/:value" => "where#index", as: "where"

  get "viewtype/expanded" => "viewtype#expanded", as: "expanded"
  get "viewtype/compact" => "viewtype#compact", as: "compact"
end

Rails.application.routes.draw do
  root "high_voltage/pages#show", id: "index"
  get "compare/:first/:second" => "compare#index"
  get "viewtype/expanded" => "viewtype#expanded", as: "expanded"
  get "viewtype/compact" => "viewtype#compact", as: "compact"
end

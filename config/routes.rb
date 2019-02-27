Rails.application.routes.draw do
  root "high_voltage/pages#show", id: "index"

  get "compare/:first/:second" => "compare#index", as: "compare"
  get "where/:where/:value" => "where#index", as: "where"

  get "viewtype/expanded" => "viewtype#expanded", as: "expanded"
  get "viewtype/compact" => "viewtype#compact", as: "compact"

  get "theme/light" => "theme#light", as: "theme_light"
  get "theme/dark" => "theme#dark", as: "theme_dark"

  get "alldata/expanded" => "alldata#expanded", as: "alldata_expanded"
  get "alldata/compact" => "alldata#compact", as: "alldata_compact"

  get "legends" => "legends#index"
  get "legends/:name" => "legends#show", as: "legend_show"

  get "sort/:items/:sort_by" => "sort#index", as: "sort"
end

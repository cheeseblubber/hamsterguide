Rails.application.routes.draw do
  root to: 'laptops#root'
  resources :laptops, only: :index, defaults: { format: :json }
end

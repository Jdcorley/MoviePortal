Rails.application.routes.draw do
  resources :shows, only: [:index, :show, :about]
  get 'about', to: 'pages#about', as: 'about'
  root 'shows#index'
end

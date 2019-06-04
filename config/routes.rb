Rails.application.routes.draw do
  get 'attendances/create'

  get 'sessions/new'

  root 'first#home'
  get '/singup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/edit-basic-info/:id', to: 'users#edit_basic_info', as: :basic_info
  patch 'update-basic-info', to: 'users#update_basic_info'
  get 'users/:id/attendances/new_overtime', to: 'attendances#new_overtime', as: :new_overtime
  get 'users/:id/attendances/:date/edit', to: 'attendances#edit', as: :edit_attendances
  patch 'users/:id/attendances/:date/update', to: 'attendances#update', as: :update_attendances  
  get 'users/:id/attendances/create_overtime', to: 'attendances#create_overtime', as: :create_overtime
  resources :users do
    resources :attendances, only: :create
  end
end

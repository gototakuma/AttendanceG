Rails.application.routes.draw do

  get 'sessions/new'

  root 'first#home'
  get '/singup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/edit-basic-info/:id', to: 'users#edit_basic_info', as: :basic_info
  patch 'update-basic-info', to: 'users#update_basic_info'
  patch 'users/:id/attendances/:id/update_overtime', to: 'attendances#update_overtime', as: :update_overtime #残業申請
  get 'users/:id/attendances/:id/receive_overtime', to: 'attendances#receive_overtime', as: :receive_overtime
  patch 'users/:id/attendances/:id/update_receive_overtime', to: 'attendances#update_receive_overtime', as: :update_receive_overtime #残業申請のお知らせ
  get 'users/:id/attendances/:date/edit', to: 'attendances#edit', as: :edit_attendances
  patch 'users/:id/attendances/:date/update', to: 'attendances#update', as: :update_attendances
  get 'users/:id/attendances/:id/receive_attendance', to: 'attendances#receive_attendance', as: :receive_attendance #勤怠変更のお知らせ
  patch 'users/:id/attendances/:id/update_receive_attendance', to: 'attendances#update_receive_attendance', as: :update_receive_attendance #勤怠変更のお知らせ
  resources :users do
    resources :attendances
  end
end

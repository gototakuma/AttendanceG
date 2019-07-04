Rails.application.routes.draw do
  root 'first#home'
  get '/singup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/edit-basic-info/:id', to: 'users#edit_basic_info', as: :basic_info
  patch 'update-basic-info', to: 'users#update_basic_info'
  get 'users/attendances_now', to: 'users#attendances_now', as: :attendances_now
  patch 'users/:id/attendances/:id/update_overtime', to: 'attendances#update_overtime', as: :update_overtime #残業申請
  patch 'users/:id/attendances/:id/update_month', to: 'attendances#update_month', as: :update_month #所属長申請
  get 'users/:id/attendances/:id/receive_overtime', to: 'attendances#receive_overtime', as: :receive_overtime#残業申請のお知らせ
  patch 'users/:id/attendances/:id/update_receive', to: 'attendances#update_receive', as: :update_receive #~申請のお知らせ(update)
  get 'users/:id/attendances/:date/edit', to: 'attendances#edit', as: :edit_attendances#勤怠を編集
  get 'users/:id/attendances/:date/atlog', to: 'attendances#atlog', as: :atlog#勤怠修正ログ
  patch 'users/:id/attendances/:date/update', to: 'attendances#update', as: :update_attendances#勤怠を編集(update)
  get 'users/:id/attendances/:id/receive_attendance', to: 'attendances#receive_attendance', as: :receive_attendance #勤怠変更のお知らせ
  patch 'users/:id/attendances/:id/update_receive_attendance', to: 'attendances#update_receive_attendance', as: :update_receive_attendance #勤怠変更のお知らせ
  get 'users/:id/attendances/:id/receive_month', to: 'attendances#receive_month', as: :receive_month#所属長承認のお知らせ
  
  resources :users do
    resources :attendances
  end
  
  resources :bases
  
  resources 'users', only: :index do
    collection { post :import }
  end
end

Rails.application.routes.draw do
  root 'first#home'
  get '/singup', to: 'users#new'
end

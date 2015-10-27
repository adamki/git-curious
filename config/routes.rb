Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/github', as: :login
  get '/auth/github/callback' => 'sessions#create'
  get "/logout" => 'sessions#destroy'
end

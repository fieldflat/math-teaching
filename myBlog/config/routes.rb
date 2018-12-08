Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "home#index"
  get "/users/new" => "users#new"
  post "/users/create" => "users#create"
  get "/users/login_form" => "users#login_form"
  post "/users/login" => "users#login"
  post "/users/logout" => "users#logout"

  get "/users/:id/show" => "users#show"
  get "/users/:id/edit" => "users#edit"
  post "/users/:id/update" => "users#update"

  get "/questions/index" => "questions#index"
  get "/questions/new" => "questions#new"
  get "/questions/:id/show" => "questions#show"
  post "/questions/:id/create" => "questions#create"
  get "/questions/:id/edit" => "questions#edit"
  post "/questions/:id/update" => "questions#update"
  post "/questions/:id/destroy" => "questions#destroy"

  post "/answers/:user_id/:question_id" => "answers#create"
  post "/answers/destroy/:user_id/:question_id" => "answers#destroy"


end

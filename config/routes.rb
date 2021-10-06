Rails.application.routes.draw do
  # devise_for :users
  namespace :api do
    namespace :v1 do
      resources :posts
      post "/signup" => "users#signup"
      post "/login" => "users#login"
    end

  end
end

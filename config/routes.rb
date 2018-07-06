Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  resources :users
  resources :users do
    resources :posts
  end

  resources :posts

end

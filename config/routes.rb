Rails.application.routes.draw do

  devise_for :users
  get 'welcome/index'

  resources :materials do
      resources :reviews, except: [:show, :index]
      member do
          put "like", to: "materials#upvote"
      end

  end

  authenticated :user do
      root 'materials#index', as: "authenticated_root"
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

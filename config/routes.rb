Rails.application.routes.draw do
  namespace :public do
    resources :items, only:[:index, :show]
  end
  scope module: :public do
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end

  scope module: :public do
    get "customers/current_customer" => "customers#show"
    get "customers/confirm" => "customers#confirm"
    patch "customers/withdraw" => "customers#withdraw"
    resource :customers, only: [:edit, :update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    resources :items, expect: [:destroy]
  end
  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update]
  end

  root to: "public/homes#top"
  get "homes/about" => "public/homes#about"

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

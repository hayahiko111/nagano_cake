Rails.application.routes.draw do
  namespace :admin do
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
  end
  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update]
  end
  root to: "public/homes#top"

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  get "homes/about" => "public/homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

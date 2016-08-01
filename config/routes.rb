Rails.application.routes.draw do

  resources :blogs do
    resources :comments
    
    collection do
      post :confirm
      post 'blogs' => 'blogs#new', :path => '/new'
    end
  end

  resources :contacts, only: [:index, :new, :create] do
    collection do
      post :confirm
    end
  end
  
  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]

end
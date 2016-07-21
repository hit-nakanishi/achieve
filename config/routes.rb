Rails.application.routes.draw do

  resources :blogs, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end

  resources :contacts, only: [:index, :new, :create] do
    collection do
      post :confirm
    end
  end
  
  devise_for :users

  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
Rails.application.routes.draw do

  root 'top#index'

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
  
  
end

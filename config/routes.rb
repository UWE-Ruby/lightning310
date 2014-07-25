Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', to: 'home#index', as: :new_user_session
    get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'change_locale', to: 'locales#change'

  resources :topics do
    member do
      get 'complete'
      get 'approve'
    end
  end
  root to: 'home#index'
end

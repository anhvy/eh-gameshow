# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :homes, path: '/game' do
    collection do
      get 'streaming'
    end
  end

  resources :episodes

  resources :questions do
    collection do
      get :import
      match :assign, via: [:get, :post]
    end
  end

  resources :rounds do
    collection do
      get 'broadcasted_question'
      get 'current_score'
      post 'set_broadcast_question'
    end
  end

  resources :broadcasts do
    collection do
      get 'broadcasted_question'
      get 'current_score'
      post 'set_broadcast_question'
    end
  end
end

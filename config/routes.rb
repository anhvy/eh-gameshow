# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'

  resources :homes, path: '/game' do
    collection do
      get 'streaming'
    end
  end

  # Currently we use ActionController::Live which cause warden error,
  # so I put authentication here as a work around solution
  authenticate do
    resources :episodes

    # resources :rounds do
    #   collection do
    #     get 'broadcasted_question'
    #     get 'current_score'
    #     post 'set_broadcast_question'
    #   end
    # end

    resources :questions do
      collection do
        get :import
        match :assign, via: [:get, :post]
      end
    end
  end

  resources :rounds do
    collection do
      get 'broadcasted_question'
      get 'current_score'
      post 'set_broadcast_question'
    end
  end
end

Rails.application.routes.draw do
  root 'homes#index'

  resources :episodes
  resources :questions do
    collection do
      get :import
    end
  end


  resources :homes, path: '/game' do
    collection do
      get 'streaming'
    end
  end

  resources :rounds do
    collection do
      get 'broadcasted_question'
      post 'set_broadcast_question'
    end
  end
end

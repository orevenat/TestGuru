Rails.application.routes.draw do
  root to: 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login,
                                                 sign_out: :logout }

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  resources :badges, only: %i[index]
  get '/my_badges' => 'badges#my_badges'

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  get '/admin' => 'admin/tests#index', as: :admin_root
  namespace :admin do
    resources :gists, only: :index
    resources :badges
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
  end

  resource :feedbacks, only: %i[new create] do
    get :result
  end
end

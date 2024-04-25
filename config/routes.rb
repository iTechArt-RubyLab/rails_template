# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: %i(
    confirmations
    omniauth_callbacks
    passwords
    registrations
    sessions
    unlocks
  ).map { |controller| { controller => "users/#{controller}" } }.reduce(:merge)

  devise_scope :user do
    authenticated :user do
      root to: 'home#homepage'
    end

    unauthenticated :user do
      root to: 'users/sessions#new', as: :unauthenticated_root
    end
  end


  devise_for :api_users, path: '', controllers: {
    sessions: 'api/users/sessions',
    registrations: 'api/users/registrations'
  }, skip: %i(sessions registrations)

  devise_scope :api_user do
    defaults format: :json do
      post 'api/users/sign_up', to: 'api/users/registrations#create'
      post 'api/users/sign_in', to: 'api/users/sessions#create'
      delete 'api/users/sign_out', to: 'api/users/sessions#destroy'
    end
  end

  authenticate :user, ->(user) { user.allowed_to_access_dashboards? } do
    mount Sidekiq::Web, at: '/sidekiq'
    mount PgHero::Engine, at: '/pghero'
  end

  mount Rswag::Ui::Engine, at: '/api-docs'
  mount Rswag::Api::Engine, at: '/api-docs'


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resource :two_factor_authentication_settings, except: %i(index show)

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :users, only: %i(index show)
        get '/current_user', to: 'users#current_user'

        get '/charts_data', to: 'charts#data'
      end
    end
  end

  resources :users, except: :destroy

  get 'pdf', to: 'pdfs#print'
end

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

  devise_for :api_users, path: '', path_names: {
    sign_in: 'api_sign_in',
    sign_out: 'api_sign_out',
    registration: 'api_sign_up'
  },
  controllers: {
    sessions: 'api_users/sessions',
    registrations: 'api_users/registrations'
  }

  mount Sidekiq::Web, at: '/sidekiq'
  mount PgHero::Engine, at: '/pghero'

  devise_scope :user do
    authenticated :user do
      root to: 'home#homepage'
    end

    unauthenticated :user do
      root to: 'users/sessions#new', as: :unauthenticated_root
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resource :two_factor_authentication_settings, except: %i(index show)

  get 'pdf', to: 'pdfs#print'
end

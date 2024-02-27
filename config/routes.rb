# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  mount Sidekiq::Web, at: '/sidekiq'
  mount PgHero::Engine, at: '/pghero'

  devise_scope :user do
    authenticated :user do
      root to: 'home#homepage'
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'pdf', to: 'pdfs#print'
end

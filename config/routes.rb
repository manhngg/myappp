
Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  scope "(:locale)", locale: /en|vi/ do
    resources :discounts, only: :update
    resources :carts, only: %i(show destroy)
    resources :line_items
    devise_for :users, controllers: { registrations: "registrations" }
    resources :users, only: %i(show) do
      resources :orders, only: :show
    end
    resources :brands, only: %i(show index)
    resources :products, only: %i(show index) do
      resources :comments
    end
    root "static_pages#index"
    post "orders/new", to: "orders#create"
    get "admin", to: "admin#index"
    namespace :admin do
      resources :coupons
      resources :products
      resources :brands
      resources :orders
      resources :users
      resources :static_pages, only: %i(index)
      resources :notifications, only: %i(index update)
    end
    root "static_pages#index"
    resources :orders, except: :destroy
    post "orders/new", to: "orders#create"
    get :search, to: "searches#index"
    resources :products
    mount ActionCable.server, at: "/cable"
  end
end

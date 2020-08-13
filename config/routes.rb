Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :articles
    end
  end

  root 'articles#index'
  resources :articles, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :articles, only: %w[index create show update]
    end
  end

  root 'articles#index'
  get 'articles/:id', to: 'articles#index'
  get 'articles/new', to: 'artciels#index'
  get 'articles/:id/edit', to: 'articles#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # module the controllers without affecting the URI
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :todos, only: :index
  end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :todos do
      resources :items
    end
    resources :recipes do
      resources :ingredients
    end
  end

  post 'users/authenticate', to: 'authentication#authenticate'
  post 'users/register', to: 'users#create'
  resources :users
end

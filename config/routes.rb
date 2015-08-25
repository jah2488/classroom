Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks", }

  resources :reports
  resources :instructors
  resources :checkins
  resources :students do
    get :become
  end
  resources :cohorts, only: :show

  resources :submissions do
    patch :complete
    patch :unfinish
  end

  resources :adjustments, only: :create do
    member do
      patch :adjust
      patch :close
    end
  end

  resources :assignments, only: [:show] do
    collection do
      get :current
      get :search
    end
  end

  namespace 'staff' do
    root to: 'cohorts#show'
    resources :cohorts do
      resources :days
      resources :assignments
      resources :reports
    end
    resources :campuses
    resources :students, only: [:show, :edit, :update]
    resources :badges, except: :index
    resources :ratings, only: [:create, :update]
    resources :tags, only: :create
  end

  root to: "cohorts#my"

  get '404', :to => 'application#page_not_found'
  get '422', :to => 'application#server_error'
  get '500', :to => 'application#server_error'
end

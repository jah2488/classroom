Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks", }

  resources :reports, only: [:show, :index]
  resources :instructors
  resources :checkins, only: :create
  resources :students, except: [:new] do
    get :become
  end

  resources :badges, except: :show
  resources :cohorts, only: [:show, :index]
  resources :users, only: :index

  resources :submissions do
    patch :complete
    patch :unfinish
  end
  resources :ratings, only: [:create, :update]

  resources :adjustments, only: :create do
    member do
      patch :adjust
      patch :close
    end
  end

  resources :assignments do
    collection do
      get :current
    end
  end

  namespace 'staff' do
    root to: 'cohorts#show'
    resources :cohorts do
      put :archive
      resources :days
      resources :assignments
      resources :reports
    end
    resources :campuses
    resources :students, only: [:show, :edit, :update]
    resources :tags, only: :create
  end

  root to: "cohorts#my"

  get '404', :to => 'application#page_not_found'
  get '422', :to => 'application#server_error'
  get '500', :to => 'application#server_error'
end

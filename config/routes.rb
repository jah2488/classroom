Rails.application.routes.draw do

  devise_for :students
  devise_for :instructors

  resources :reports
  resources :instructors

  resources :checkins
  resources :students
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

  authenticate :student do
    get 'dashboard' => 'dashboard#index'
    get 'my-cohort' => 'dashboard#cohort', as: 'my_cohort'
    root to: redirect('/dashboard')
  end

  authenticate :instructor do
    namespace 'staff' do
      root to: "cohorts#show"
      resources :cohorts do
        resources :days
        resources :assignments
      end
      resources :students, only: [:show, :edit, :update]
      resources :badges, except: :index
      resources :ratings, only: [:create, :update]
      resources :tags, only: :create
    end
  end

  get '404', :to => 'application#page_not_found'
  get '422', :to => 'application#server_error'
  get '500', :to => 'application#server_error'
end

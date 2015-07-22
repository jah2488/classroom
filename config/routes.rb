Rails.application.routes.draw do

  devise_for :students
  devise_for :instructors

  resources :reports
  resources :instructors
  resources :submissions do
    patch :complete
    patch :unfinish
  end

  authenticate :student do
    get 'dashboard' => 'dashboard#index'
    get 'my-cohort' => 'dashboard#cohort', as: 'my_cohort'

    resources :checkins
    resources :adjustments, only: :create

    get 'profile/:id' => 'students#show', as: 'profile'
    get 'profile/:id/edit' => 'students#edit', as: 'edit_profile'

    resources :assignments, only: [:show] do
      collection do
        get 'current'
        get 'search'
      end
    end
    resources :students
    root to: 'dashboard#index'
  end

  authenticate :instructor do
    patch 'adjustments/:id/adjust' => 'adjustments#adjust', as: 'adjust_checkin'
    patch 'adjustments/:id/close'  => 'adjustments#close',  as: 'close_adjustment'

    namespace 'staff' do
      root to: "cohorts#index"
      resources :cohorts, only: [:new, :create, :show] do
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

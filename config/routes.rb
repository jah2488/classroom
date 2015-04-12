Rails.application.routes.draw do

  devise_for :students
  devise_for :instructors

  authenticate :student do
    get 'dashboard' => 'dashboard#index'
    resources :submissions
    resources :checkins
  end

  authenticate :instructor do
    resources :instructors, only: [:show, :edit, :update]
    scope 'instructor' do
      get 'dashboard' => 'instructor_dashboard#index', as: 'instructor_dash'
      resources :cohorts
      resources :assignments
      resources :students, only: [:show, :edit, :update]
      resources :days, only: [:new, :create]
    end
  end

  root 'welcome#index'
end

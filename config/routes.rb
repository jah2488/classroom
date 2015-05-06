Rails.application.routes.draw do

  devise_for :students
  devise_for :instructors

  authenticate :student do
    get 'dashboard' => 'dashboard#index'
    resources :submissions
    resources :checkins
    get 'profile/:id' => 'students#show', as: 'profile'
    get 'profile/:id/edit' => 'students#edit', as: 'edit_profile'
    get 'assignments/:id' => 'assignments#show', as: 'student_assignment'
    resources :students
  end

  authenticate :instructor do
    resources :instructors, only: [:show, :edit, :update]
    patch 'submissions/:id/complete' => 'submissions#mark_complete', as: 'mark_submission_complete'
    patch 'submissions/:id/unfinished' => 'submissions#mark_unfinished', as: 'mark_submission_unfinished'
    scope 'instructor' do
      get 'dashboard' => 'instructor_dashboard#index', as: 'instructor_dash'
      resources :cohorts
      resources :assignments
      resources :students, only: [:show, :edit, :update]
      resources :days, only: [:new, :create]
    end
  end

  authenticate :student do
    root 'dashboard#index'
  end
end

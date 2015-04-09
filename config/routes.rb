Rails.application.routes.draw do

  get 'students/show'

  get 'students/edit'

  get 'students/update'

  devise_for :students
  devise_for :instructors

  authenticate :student do
    get 'dashboard' => 'dashboard#index'
  end

  authenticate :instructor do
    scope 'instructor' do
      get 'dashboard' => 'instructor_dashboard#index', as: 'instructor_dash'
      resources :cohorts
      resources :assignments
      resources :students, only: [:show, :edit, :update]
    end
  end

  root 'welcome#index'
end

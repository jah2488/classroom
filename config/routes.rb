Rails.application.routes.draw do

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
    end
  end

  root 'welcome#index'
end

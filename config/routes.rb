Bugzilla::Application.routes.draw do

  get 'static_pages/home'
  root to: 'static_pages#home'

  resources :projects

  devise_for :users
  resources :users do
    put :update_password, on: :member
  end

  resources :projects do
    resources :stories
    resources :members do
      get :confirm, on: :member
    end
  end
  resources :activities

  resources :stories do
    resources :tasks
    resources :comments
    get :icebox, on: :member
    get :current, on: :member
    get :backlog, on: :member
    get :done, on: :member
  end

end

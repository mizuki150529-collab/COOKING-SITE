Rails.application.routes.draw do
  get "home/index"
  devise_for :users

  resource :user, only: [:show]

  resources :posts

  get "diagnosis",      to: "diagnoses#intro", as: :diagnosis_intro
  get "diagnosis/new",  to: "diagnoses#new",   as: :new_diagnosis
  get "diagnosis/result", to: "diagnoses#result", as: :diagnosis_result

  resources :cooking_logs, only: [:create, :destroy]

  root "home#index"
end

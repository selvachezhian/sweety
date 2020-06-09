Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :blood_glucoses, only: [:index, :new, :create] do
    collection do
      get :this_month_till_date
      get :monthly
      get :custom
    end
  end
end

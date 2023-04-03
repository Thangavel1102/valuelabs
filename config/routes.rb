Rails.application.routes.draw do
  get 'employees/index' => 'employees#index'
  post 'employees/import' => 'employees#import'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

Rails.application.routes.draw do

	root to: 'top#home'

	devise_for :users

	resources :users, only: [:show, :index, :edit, :update]

	resources :books, only: [:create, :index, :show, :edit, :destroy]

	get '/about' => 'top#about', as: 'about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

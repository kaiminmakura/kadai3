Rails.application.routes.draw do


	root to: 'top#home'

	devise_for :users

	resources :users, only: [:show, :index, :edit, :update] do
		resource :relationships, only: [:create, :destroy]
		get :follows, on: :member
		get :followers, on: :member
	end

	resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
		resource :favorites, only: [:create, :destroy]
		resources :book_comments, only: [:create, :destroy]
    end

	get '/home/about' => 'top#about', as: 'about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

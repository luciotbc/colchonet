Rails.application.routes.draw do
	scope "(:locale)", locale: /en|pt\-BR/ do
		resources :users
		resources :rooms do
			resources :reviews, only: [:create, :update], module: :rooms
		end
		resource :confirmation, only: [:show]
		resource :user_sessions, only: [:create, :new, :destroy]
		get '/:locale' => 'home#index'
	end

	root 'home#index'
end

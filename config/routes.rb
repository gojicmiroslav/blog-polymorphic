Rails.application.routes.draw do

	concern :commentable do
		resources :comments
	end

  resources :photos, concerns: :commentable
  resources :events, concerns: :commentable
  resources :articles, concerns: :commentable
  root 'articles#index'
end

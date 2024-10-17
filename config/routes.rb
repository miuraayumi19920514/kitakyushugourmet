Rails.application.routes.draw do
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: 'reviews#index'
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    resources :comments, only: [:destroy]
  end

  scope module: :user do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get '/search' => "searches#search", as: 'search'
    
    get '/users/mypage' =>'users#mypage', as: 'mypage'
    get '/users/infomation/edit' => 'users#edit', as: 'information_edit'
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    get '/users/unsubscribe/completion' => 'users#completion', as: 'completion'
    patch '/users/information' => 'users#update', as: 'information'
    patch '/users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :users, only: [:index, :show] do
      resources :favorites, only: [:index]
    end
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

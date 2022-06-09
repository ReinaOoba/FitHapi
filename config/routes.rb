Rails.application.routes.draw do
# 管理者用
devise_for :admin, controllers: {
  sessions: "admin/sessions",
  # passwords: 'admin/passwords'
}

# 管理者ルーティング設定
namespace :admin do
  root to: 'homes#top'
  # get "search" => "searches#search"
  resources :users, only: [:index,:show,:edit,:update] do
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :articles, only: [:index, :show, :edit, :update, :destroy]
  resources :comments, only: [:index, :delete]
  resources :categories
  resources :tags, only: [:index, :new, :edit, :create, :update, :destroy]
  resources :taglists, only: [:edit, :update, :destroy]
  resources :mytrainings, only: [:index, :show, :edit, :update, :destroy]
  resources :weights, only: [:index, :show, :edit, :update, :destroy]
end

# 会員用
 devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions', 
  passwords: 'public/passwords'
}
 devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#new_guest'
  end

# 会員ルーティング設定
  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'help' => 'public/homes#help'
  get 'policy_agreement' => 'public/homes#policy_agreement'
# get "search" => "public/searches#search"　検索機能未実装

  scope module: :public do
    resources :users, except: [:destroy], param: :account do
      resources :relationships, only: [:create, :destroy]
      get 'unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      patch 'withdrawal' => 'users#withdrawal', as: 'withdrawal'
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      resources :mytrainings
      resources :weights, only: [:index, :new, :edit, :create, :update, :destroy]
      resources :favorites, only: [:index]
    end
    resources :articles do
      resources :comments, only: [:new, :edit, :create, :update, :destroy]
      resource :favorites, only: [:new, :create, :destroy]
    end
    get 'hot' => 'articles#hot'
    get 'new_arrival' => 'articles#new_arrival'
    resources :categories, only: [:index]
    resources :tags, only: [:new, :create, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

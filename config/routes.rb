Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    get '' => 'homes#top'
    resources :reviews, only: [:show, :destroy]
    resources :large_categories, except: [:new, :show] do
      resources :item_categories, except: [:new, :show]
    end
    resources :users, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'

    resources :posts, except: [:destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :post_favorites, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update] do
      get 'my_posts' => 'users#my_posts'
      get 'my_favorites' => 'users#my_favorites'
      get 'confirm' => 'users#confirm'
      patch 'deleted' => 'users#deleted'
    end

    get 'search' => 'searches#search'
    get 'category/:id' => 'seaches#large_category_search'
    get 'category/:large_category_id/item_category/:id' => 'seaches#item_category_seach'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

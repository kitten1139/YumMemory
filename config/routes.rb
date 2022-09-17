Rails.application.routes.draw do

  namespace :public do
    get 'categories/index'
  end
  namespace :admin do
    get 'item_categories/index'
    get 'item_categories/edit'
  end
  namespace :admin do
    get 'large_categories/index'
    get 'large_categories/edit'
  end
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
    resources :posts, only: [:show, :destroy] do
      delete 'post_comments/:id' => 'posts#comment_destroy', as: 'comment_destroy'
    end
    resources :large_categories, except: [:new, :show] , shallow: true do
      resources :item_categories, except: [:new, :show]
    end
    resources :users, only: [:index, :show, :edit, :update]
  end

  scope module: :public do
    root 'homes#top'
    get 'about' => 'homes#about'

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :post_favorites, only: [:create, :destroy]
    end

    resources :categories, only: [:index]

    resources :users, only: [:show, :edit, :update] do
      get 'my_posts' => 'users#my_posts'
      get 'my_favorites' => 'users#my_favorites'
      get 'confirm' => 'users#confirm'
      patch 'deleted' => 'users#deleted'
    end

    get 'search' => 'searches#search'
    get 'category/:id' => 'searches#large_category_search', as: 'large_category_search'
    get 'category/:large_category_id/item_category/:id' => 'searches#item_category_search', as: 'item_category_search'
    get 'get_item_category' => 'categories#get_item_category'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

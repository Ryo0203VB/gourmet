Rails.application.routes.draw do

  # 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

 namespace :admin do
   get "/homes" => "homes#top"
   resources :genres, only:[:index, :create, :edit, :update, :destroy]
   resources :users, only:[:index, :show, :edit, :update]
end

  # 顧客用
# URL /customers/sign_in ...
devise_for :user, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
# public（顧客側のルーディング）
  scope module: :user do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    
    resources :users, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"
    end
    # URLの置き換え
    get "users/confirm_withdraw" => "users#confirm_withdraw"
    patch "users/withdraw" => "user#withdraw"

    resources :posts, only:[:new, :index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    end
  end

devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end


end

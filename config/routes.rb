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
    # URLの置き換え
    get "users/information" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "users/confirm_withdraw" => "userss#confirm_withdraw"
    patch "users/withdraw" => "user#withdraw"

end



end

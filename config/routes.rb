Rails.application.routes.draw do
 # 会員用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
　passwords: 'public/passwords'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions",
  passwords: 'admin/passwords'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

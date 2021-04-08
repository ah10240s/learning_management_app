Rails.application.routes.draw do



  # rootをログイン画面に設定
  # devise_scope :user do
  #   root "users/sessions#new"
  # end

  root :to => 'mypage#home'

  # resources :mypage

  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # get  '/test',  to: 'mypage#show'

  # get  '/mypage/:id',  to: 'mypage#home', as: 'mypage'
  # get  '/users/:id',  to: 'mypage#home'
  
  # resources :mypage
end

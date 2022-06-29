Rails.application.routes.draw do



devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    resources :items
    resource :customers, only: [:update]
    get "customers/my_page/edit" => "customers#edit", as: "edit_customers"
    get '/mypage' => 'customers#mypage'
    get "/customers" => "customers#unsubscribe", as: "unsubscribe_customer"
    get "/customers/withdraw" => "customers#withdraw"
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    post "/orders/comfirm" => "orders#comfirm", as: "orders_comfirm"
    get "/orders/thanks" => "orders#thanks"
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses
  end

  namespace :admin do
    get 'homes/top'
    resources :items
    resources :genres
    resources :customers
    resources :orders
    resources :order_items
  end



end








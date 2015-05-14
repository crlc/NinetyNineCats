NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end
  resource :user, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :show, :destroy]

  root to: redirect("/cats")
end

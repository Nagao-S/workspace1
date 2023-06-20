Rails.application.routes.draw do
  scope '/api' do
    resources :articles, param: :slug, only: [:create, :show, :update, :destroy]
  end
end
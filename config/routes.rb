Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/communities', to: 'communities#index'
  get '/communities/:community_id', to: 'communities#show'
  post '/communities', to: 'communities#create'
end

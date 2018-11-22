Rails.application.routes.draw do
  resources :posts do
  	resources :ratings
  end

  get 'top/:n', to: 'posts#top'
  get 'ips/', to: 'posts#ips'
end

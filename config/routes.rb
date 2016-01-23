Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }, only: [:sessions]

  get 'top/index'

  get 'fasta_data/destroy_all'

  post 'fasta_data/upload'

  get 'fasta_data/merge'

  resources :fasta_data

  root to: 'top#index'

  match "*path" => "application#render_404", via: :all
end

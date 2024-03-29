Tupley::Application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    get 'tags/:tags' => 'tags#show', as: :tag
    resources :tasks, only: [:create, :update, :destroy]
    resource :default_tags, only: [:update]
    root to: 'tasks#index'
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: 'high_voltage/pages#show', id: 'home'
  end
end

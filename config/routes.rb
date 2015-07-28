Rails.application.routes.draw do
  root to: "tracked_urls#new"

  resources :tracked_urls, path: '', only: [:create, :show],
    param: :slug,
    constraints: { slug: /[a-zA-Z0-9_-]{1,14}/ },
    defaults: { format: :json }
end

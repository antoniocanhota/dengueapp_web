Dengueapp::Application.routes.draw do

  get "home/administrador"

  get "home/moderador"
  
  #get "home/denunciante"

  match "home/denunciate" =>  "public#index", :as => "home_denunciante"

  match "acesso_negado" => "application#acesso_negado", :as => "acesso_negado"
  
  match "minhas_denuncias" => "denuncias#minhas_denuncias", :as => "minhas_denuncias"
  
  match "webservices/denuncias" => "webservices#denuncias", :as => "webservice_denuncias"
  
  match "webservices/denuncias/publicar" => "webservices#publicar_denuncia", :as => "webservice_publicar_denuncia", :via => :post

  devise_for :usuarios
  
  match 'operadores/:id/desativar' => 'operadores#desativar', :as => "desativar_operador"
  match 'operadores/:id/ativar' => 'operadores#ativar', :as => "ativar_operador"
  resources :operadores do
    get 'administradores', :on => :collection
    get 'moderadores', :on => :collection
  end

  match 'denuncias/:id/rejeitar' => 'denuncias#rejeitar', :as => "rejeitar_denuncia"
  match 'denuncias/:id/reativar' => 'denuncias#reativar', :as => "reativar_denuncia"
  resources :denuncias do
    get 'ativas', :on => :collection
    get 'rejeitadas', :on => :collection
    get 'canceladas', :on => :collection
    get 'resolvidas', :on => :collection
  end
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  authenticated :usuario do
    root :to => 'home#index'
  end
  root :to => 'public#index'

  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

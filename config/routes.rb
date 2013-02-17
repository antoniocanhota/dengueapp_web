Dengueapp::Application.routes.draw do

  get "home/administrador"

  get "home/moderador"
  
  #get "home/denunciante"

  match "home/denunciate" =>  "public#index", :as => "home_denunciante"

  match "download" => "public#download", :as => "download"

  match "download/android" => "public#download_android", :as => "download_android"

  match "conheca_a_aplicacao" => "public#conheca_a_aplicacao", :as => "conheca_a_aplicacao"

  match "acesso_negado" => "application#acesso_negado", :as => "acesso_negado"
  
  match "webservices/denuncias" => "webservices#denuncias", :as => "webservice_denuncias"
  
  match "webservices/denuncias_do_usuario/:identificador_do_android" => "webservices#denuncias_do_usuario", :as => "webservice_denuncias_do_usuario"
    
  match "webservices/denuncias/publicar" => "webservices#publicar_denuncia", :as => "webservice_publicar_denuncia", :via => :post
  
  match "webservices/registro_do_dispositivo/:identificador_do_android" => "webservices#registro_do_dispositivo", :as => "webservice_registro_do_dispositivo"

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
    get 'estatisticas', :on => :collection
    get 'update_situacao'
  end

  resources :dispositivos do
    put 'vincular', :on => :collection
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

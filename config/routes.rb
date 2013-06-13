Dengueapp::Application.routes.draw do

  get "denunciantes/index"

  match "download" => "public#download", :as => "download"
  match "download/android" => "public#download_android", :as => "download_android"
  match "conheca_a_aplicacao" => "public#conheca_a_aplicacao", :as => "conheca_a_aplicacao"
  match "estatisticas" => "public#estatisticas", :as => "estatisticas"

  match "acesso_negado" => "application#acesso_negado", :as => "acesso_negado"
  
  match "webservices/denuncias" => "webservices#denuncias", :as => "webservice_denuncias"
  match "webservices/denuncias/publicar" => "webservices#publicar_denuncia", :as => "webservice_publicar_denuncia", :via => :post
  match "webservices/reportar_excecao" => "webservices#reportar_excecao", :as => "webservice_reportar_excecao", :via => :post
  match "webservices/registro_do_dispositivo/:identificador_do_android" => "webservices#registro_do_dispositivo", :as => "webservice_registro_do_dispositivo"

  match "usuario/:id/cancelar/" => "devise/registrations#cancelar", :as => "cancelar_usuario_registration"
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
    get 'update_situacao'
  end

  resources :denunciantes, :only => [:index] do
    get 'banir', :on => :collection
  end

  resources :dispositivos do
    put 'vincular', :on => :collection
  end
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  authenticated :usuario do
    root :to => 'public#index'
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

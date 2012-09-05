#encoding: UTF-8
FactoryGirl.define do
  factory :operador do
    
    situacao Operador::ATIVO
    association :usuario
    
    factory :administrador do
      tipo Operador::ADMINISTRADOR
      association :usuario#, :email => "administrador@mail.com"
      
      factory :administrador_inativo do
        situacao Operador::INATIVO
        association :usuario#, :email => "administrador_inativo@mail.com"
      end
      
      factory :administrador_precadastrado do
        situacao Operador::PRECADASTRADO
        association :usuario#, :email => "administrador_precadastrado@mail.com"
      end
      
    end

    factory :moderador do
      tipo Operador::MODERADOR
      association :usuario#, :email => "moderador@mail.com"
      
      factory :moderador_inativo do
        situacao Operador::INATIVO
        association :usuario#, :email => "moderador_inativo@mail.com"
      end
      
      factory :moderador_precadastrado do
        situacao Operador::PRECADASTRADO
        association :usuario#, :email => "moderador_precadastrado@mail.com"
      end
      
    end
    
  end
end
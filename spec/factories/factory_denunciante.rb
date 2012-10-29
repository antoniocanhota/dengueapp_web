#encoding: UTF-8
FactoryGirl.define do
  factory :denunciante do
    
    situacao Denunciante::CADASTRADO    
    
    factory :denunciante_com_login do
      association :usuario#, :email => "denunciante@mail.com"
    end
    
    factory :denunciante_banivel do
      after_create do |denunciante|
        Factory.create(:denuncia_rejeitada, :denunciante => denunciante)
        Factory.create(:denuncia_rejeitada, :denunciante => denunciante)
        Factory.create(:denuncia_rejeitada, :denunciante => denunciante)
      end
      
      factory :denunciante_banido do
        situacao Denunciante::BANIDO
      end
      
    end
    
    factory :denunciante_desistente do
        situacao Denunciante::DESISTENTE
    end
    
  end
end
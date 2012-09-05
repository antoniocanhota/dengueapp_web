#encoding: UTF-8
FactoryGirl.define do
  factory :denuncia do
#    data_e_hora Time.now
    latitude "-22.906351"
    longitude "-43.133343"
    situacao Denuncia::ATIVA
    association :denunciante
    
    factory :denuncia_rejeitada do
      situacao Denuncia::REJEITADA
    end
    
    factory :denuncia_cancelada do
      situacao Denuncia::CANCELADA
    end
    
    factory :denuncia_resolvida do
      situacao Denuncia::RESOLVIDA
    end
    
  end
end
#!/bin/env ruby
# encoding: utf-8

namespace :exemplos do
  
  desc 'Cria denúncias diversas no sistema'
  task :denuncias => :environment do
    #Denunciante com 2 denúncias ativas
    denunciante_1 = Denunciante.create(
      :telefone => "+552178709078",
      :situacao => Denunciante::CADASTRADO
    )
    Denuncia.create(
      :data_e_hora => Time.now-7,
      :latitude => -22.898454 ,
      :longitude => -43.134212 ,
      :situacao => Denuncia::ATIVA,
      :denunciante_id => denunciante_1.id
    )
    Denuncia.create(
      :data_e_hora => Time.now-3,
      :latitude => -22.898148 ,
      :longitude => -43.113828 ,
      :situacao => Denuncia::ATIVA,
      :denunciante_id => denunciante_1.id
    )
    #Denunciante com 1 denúncia resolvida
    denunciante_2 = Denunciante.create(
      :telefone => "+552172107090",
      :situacao => Denunciante::CADASTRADO
    )
    Denuncia.create(
      :data_e_hora => Time.now-15,
      :latitude => -23.000906 ,
      :longitude => -43.488479 ,
      :situacao => Denuncia::RESOLVIDA,
      :denunciante_id => denunciante_2.id
    )
    #Denunciante banido
    denunciante_3 = Denunciante.create(
      :telefone => "+552173847239",
      :situacao => Denunciante::BANIDO
    )
    Denuncia.create(
      :data_e_hora => Time.now-4,
      :latitude => -22.861624 ,
      :longitude => -43.056879 ,
      :situacao => Denuncia::REJEITADA,
      :denunciante_id => denunciante_3.id
    )
    Denuncia.create(
      :data_e_hora => Time.now-4,
      :latitude => -22.723149 ,
      :longitude => -43.230858 ,
      :situacao => Denuncia::REJEITADA,
      :denunciante_id => denunciante_3.id
    )
    Denuncia.create(
      :data_e_hora => Time.now-2,
      :latitude => -22.829035 ,
      :longitude => -43.583107 ,
      :situacao => Denuncia::REJEITADA,
      :denunciante_id => denunciante_3.id
    )
    #Denunciante que desistiu
    denunciante_4 = Denunciante.create(
      :telefone => "+552173847239",
      :situacao => Denunciante::DESISTENTE
    )
    Denuncia.create(
      :data_e_hora => Time.now-20,
      :latitude => -22.816041 ,
      :longitude => -43.217468 ,
      :situacao => Denuncia::CANCELADA,
      :denunciante_id => denunciante_4.id
    )
  end
  
end
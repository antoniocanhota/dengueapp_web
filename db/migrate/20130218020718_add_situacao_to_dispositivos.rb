class AddSituacaoToDispositivos < ActiveRecord::Migration
  def up
    add_column :dispositivos, :situacao, :string
    Dispositivo.find_each do |di|
      if di.usuario and di.usuario.denunciante_situacao == Usuario::DENUNCIANTE_BANIDO
        di.update_attribute(:situacao,Dispositivo::BANIDO)
      else
        di.update_attribute(:situacao,Dispositivo::CADASTRADO)
      end
    end
  end

  def down
    remove_column :dispositivos, :situacao
  end
end

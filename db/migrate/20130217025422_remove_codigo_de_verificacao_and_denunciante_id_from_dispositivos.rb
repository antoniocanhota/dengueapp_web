class RemoveCodigoDeVerificacaoAndDenuncianteIdFromDispositivos < ActiveRecord::Migration
  def up
    remove_column :dispositivos, :denunciante_id
    remove_column :dispositivos, :codigo_de_verificacao
  end

  def down
    add_column :dispositivos, :denunciante_id, :string
    add_column :dispositivos, :codigo_de_verificacao, :string
  end
end

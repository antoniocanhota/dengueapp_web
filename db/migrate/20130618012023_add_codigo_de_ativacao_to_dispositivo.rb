class AddCodigoDeAtivacaoToDispositivo < ActiveRecord::Migration
  def change
    add_column :dispositivos, :codigo_de_ativacao, :integer
  end
end

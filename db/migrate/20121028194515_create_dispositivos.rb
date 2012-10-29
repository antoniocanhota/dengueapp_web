class CreateDispositivos < ActiveRecord::Migration
  def change
    create_table :dispositivos do |t|
      t.string :numero_do_telefone
      t.string :identificador_do_hardware
      t.string :identificador_do_android
      t.string :codigo_de_verificacao      
      
      t.timestamps
    end
  end
end

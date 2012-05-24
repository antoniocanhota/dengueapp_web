class CreateDenuncias < ActiveRecord::Migration
  def change
    create_table :denuncias do |t|
      t.datetime :data_e_hora
      t.float :latitude
      t.float :longitude
      t.string :situacao, :limit => 4
      
      t.integer :denunciante_id, :null => false

      t.timestamps
    end
  end
end

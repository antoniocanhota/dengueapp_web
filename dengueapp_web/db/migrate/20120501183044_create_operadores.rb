class CreateOperadores < ActiveRecord::Migration
  def change
    create_table :operadores do |t|
      t.string :tipo, :limit => 4
      t.string :situacao, :limit => 4

      t.integer :usuario_id, :null => false
      
      t.timestamps
    end
  end
end

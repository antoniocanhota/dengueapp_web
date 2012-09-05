class CreateDenunciantes < ActiveRecord::Migration
  def change
    create_table :denunciantes do |t|
      t.string :telefone
      t.string :situacao, :limit => 4
      
      t.integer :usuario_id

      t.timestamps
    end
  end
end

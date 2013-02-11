class RemoveDenuncianteIdFromDenuncia < ActiveRecord::Migration
  def up
    remove_column :denuncias, :denunciante_id
  end

  def down
    add_column :denuncias, :denunciante_id, :integer
  end
end

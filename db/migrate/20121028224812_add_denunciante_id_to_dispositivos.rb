class AddDenuncianteIdToDispositivos < ActiveRecord::Migration
  def change
    add_column :dispositivos, :denunciante_id, :integer, :null => false
  end
end

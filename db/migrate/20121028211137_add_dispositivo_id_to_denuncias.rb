class AddDispositivoIdToDenuncias < ActiveRecord::Migration
  def change
    add_column :denuncias, :dispositivo_id, :integer, :null => false
  end
end

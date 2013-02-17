class AddApelidoToDispositivos < ActiveRecord::Migration
  def change
    add_column :dispositivos, :apelido, :string
  end
end

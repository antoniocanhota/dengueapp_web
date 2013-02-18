class AddBanivelToDispositivos < ActiveRecord::Migration
  def change
    add_column :dispositivos, :banivel, :boolean
  end
end

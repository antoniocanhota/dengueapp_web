class AddBanivelToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :banivel, :boolean
  end
end

class RemoveTelefoneFromDenunciantes < ActiveRecord::Migration
  def up
    remove_column :denunciantes, :telefone
  end

  def down
    add_column :denunciantes, :telefone, :string
  end
end

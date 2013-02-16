class AddCidadeAndBairroToDenuncias < ActiveRecord::Migration
  def change
    add_column :denuncias, :cidade, :string
    add_column :denuncias, :bairro, :string
  end
end

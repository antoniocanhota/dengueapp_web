class ChangeModeradorAndAdministradorFromUsuarios < ActiveRecord::Migration
  def up
    add_column :usuarios, :tipo_operador, :integer
    Usuario.find_each do |u|
      if u.administrador == true
        u.update_attribute(:tipo_operador,Usuario::ADMINISTRADOR)
      elsif u.moderador == true
        u.update_attribute(:tipo_operador,Usuario::MODERADOR)
      end
    end
    #remove_column :usuarios, :administrador
    #remove_column :usuarios, :moderador
  end

  def down
    add_column :usuarios, :administrador, :boolean
    add_column :usuarios, :moderador, :boolean
    Usuario.find_each do |u|
      if u.tipo_operador == Usuario::ADMINISTRADOR
        u.update_attribute(:administrador,true)
      elsif u.tipo_operador == Usuario::MODERADOR
        u.update_attribute(:moderador,true)
      end
    end
    remove_column :usuarios, :tipo_operador
  end
end

class DropTabelasDePerfis < ActiveRecord::Migration
  def up
    #cria a coluna situacao_denunciante e migra os dados da tabela Denunciante e aponta as novas chaves
    add_column :usuarios, :denunciante_situacao, :string, :limit => 4
    add_column :dispositivos, :usuario_id, :integer
    Denunciante.find_each do |de|
      if de.usuario
        de.usuario.update_attribute(:denunciante_situacao,de.situacao)
        de.dispositivos.find_each do |di|
          di.update_attribute(:usuario_id,de.usuario_id)
        end
      end
    end
    drop_table :denunciantes
    #cria as colunas moderador e administrador
    add_column :usuarios, :moderador, :boolean
    add_column :usuarios, :administrador, :boolean
    Operador.find_each do |o|
      if o.situacao != Operador::INATIVO
        if o.tipo == Operador::ADMINISTRADOR
          o.usuario.update_attribute(:administrador,true)
        elsif o.tipo == Operador::OPERADOR
          o.usuario.update_attribute(:moderador,true)
        end
      end
    end
    drop_table :operadores
  end

  def down
    #TODO
  end
end

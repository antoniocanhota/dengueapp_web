class Dispositivo < ActiveRecord::Base
  
  has_many :denuncias  
  belongs_to :denunciante
  
  before_create :gerar_codigo_de_verificacao,
    :codificar_numero_de_telefone
  
  private
  
  #TODO: Esse código deverá ser gerado pela aplicação Android
  def gerar_codigo_de_verificacao
    self.codigo_de_verificacao = "123456"
  end
  
  def codificar_numero_de_telefone
    #TODO: Implementar a criptografia desse dado  
  end
  
end

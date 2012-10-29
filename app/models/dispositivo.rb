class Dispositivo < ActiveRecord::Base
  
  has_many :denuncias  
  belongs_to :denunciante
  
end

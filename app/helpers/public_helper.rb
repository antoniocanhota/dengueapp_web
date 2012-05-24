module PublicHelper
  
  def resoruce_name
    :usuario
  end
  
  def resource
    @resource || Usuario.new
  end
  
  def devise_mapping
    @devise_mapping  ||= Devise.mappings[:usuario]
  end
  
end

#Especificidade do Devise para redirecionamento em caso de falha no login
#Ver: https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-when-the-user-can-not-be-authenticated

class CustomFailure < Devise::FailureApp
  
  def redirect_url
    root_path
  end
  
  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
  
end

class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # guest user (not logged in)
    cannot :manage, :all
    can :index, :home
    if usuario.administrador?
      can :administrador, :home
      can :index, Denuncia
      can :ativas, Denuncia
      can :rejeitadas, Denuncia
      can :canceladas, Denuncia
      can :resolvidas, Denuncia
      can :show, Denuncia
      can :reativar, Denuncia
      can :rejeitar, Denuncia#, :situacao => Denuncia::ATIVA
      can :index, Operador
      can :administradores, Operador
      can :moderadores, Operador
      can :new, Operador
      can :create, Operador
      can :show, Operador
      can :ativar, Operador
      can :desativar, Operador
    elsif usuario.moderador?
      can :ativas, Denuncia
      can :rejeitadas, Denuncia
      can :canceladas, Denuncia
      can :resolvidas, Denuncia
      can :show, Denuncia
      can :rejeitar, Denuncia
      can :moderador, :home
      can :index, Denuncia
    elsif usuario.denunciante?
      can :denunciante, :home
      can :minhas_denuncias, Denuncia
    end

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

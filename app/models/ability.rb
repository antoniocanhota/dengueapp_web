class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new # guest user (not logged in)
    cannot :manage, :all
    can :read, Denuncia, :situacao => Denuncia::ATIVA
    can :estatisticas, Denuncia
    if (usuario.moderador? or usuario.administrador?)
      can [:index,:update_situacao], Denuncia
      #cannot [:abandonar,:cancelar,:resolver], Denuncia
      can :ativar, Denuncia, :situacao => Denuncia::REJEITADA
      can :rejeitar, Denuncia, :situacao => Denuncia::ATIVA
      if usuario.administrador?
        can :manage, :operador
      end
    elsif usuario.denunciante?
      can [:index,:update_situacao], Denuncia, ("dispositivo_id in (select id from dispositivos where usuario_id = #{usuario.id})") do |d|
        d.dispositivo.usuario_id == usuario.id
      end
      can :read, Denuncia, :situacao => Denuncia::ATIVA
      cannot [:abandonar,:reativar,:cancelar,:resolver], Denuncia
      can :resolver, Denuncia, ("situacao = #{Denuncia::ATIVA} and dispositivo_id in (select id from dispositivos where usuario_id = #{usuario.id})") do |d|
        d.dispositivo.usuario_id == usuario.id and d.situacao == Denuncia::ATIVA
      end
      can :cancelar, Denuncia, ("situacao = #{Denuncia::ATIVA} dispositivo_id in (select id from dispositivos where usuario_id = #{usuario.id})") do |d|
        d.dispositivo.usuario_id == usuario.id and d.situacao == Denuncia::ATIVA
      end
      can :manage, Dispositivo, :usuario_id => usuario.id
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

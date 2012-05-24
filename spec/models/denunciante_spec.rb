require 'spec_helper'

describe Denunciante do

  let(:denunciante_cadastrando) {Factory.build :denunciante}
  let(:denunciante) {Factory.create :denunciante}
  let(:denunciante_banivel) {Factory.create :denunciante_banivel}
  
  describe "Relacionamentos" do
    it { should belong_to :usuario }
    it { should have_many :denuncias }
  end
  
  describe "Métodos" do
    
    describe "#atribuir_valores_iniciais" do
      it "deve atribuir a situação de CADASTRADO se não especificado" do
        denunciante_cadastrando.situacao = nil
        denunciante_cadastrando.save
        denunciante_cadastrando.situacao.should == Denunciante::CADASTRADO
      end
      it "não deve atribuir a situação de CADASTRADO se uma válida for especificada" do
        denunciante_cadastrando.situacao = Denunciante::BANIDO
        denunciante_cadastrando.save
        denunciante_cadastrando.situacao.should == Denunciante::BANIDO
      end
    end
    
    describe "#banivel?" do
      context "deve retornar verdadeiro quando" do
        it "têm 3 ou mais denúncias rejeitadas e está com situação de CADASTRADO" do
          denunciante_banivel.banivel?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "não tem 3 denúnicas rejeitadas" do
          denunciante.banivel?.should be_false
        end
        it "têm 3 ou mais denúncias rejeitadas, mas está com situação de BANIDO" do
          denunciante_banido = denunciante_banivel
          denunciante_banido.situacao = Denunciante::BANIDO
          denunciante_banido.banivel?.should be_false
        end
        it "têm 3 ou mais denúncias rejeitadas, mas está com situação de DESISTENTE" do
          denunciante_desistente = denunciante_banivel
          denunciante_desistente.situacao = Denunciante::DESISTENTE
          denunciante_desistente.banivel?.should be_false
        end
      end
    end
    
    describe "#banir" do
      context "deve banir quando" do
        it "é banível" do
          denunciante_banivel.banir
          Denunciante.find(denunciante_banivel.id).situacao.should == Denunciante::BANIDO
        end
      end
      context "não deve banir quando" do
        it "não é banível" do
          situacao_anterior = denunciante.situacao
          denunciante.banir
          Denunciante.find(denunciante.id).situacao.should == situacao_anterior
        end
      end
      it "deve rejeitar todas as demais denúncias ativas do usuário" do
        denuncia_ativa = Factory.create(:denuncia, :denunciante => denunciante_banivel)
        denunciante_banivel.banir
        Denuncia.find(denuncia_ativa.id).situacao.should == Denuncia::REJEITADA
      end
      it "não deve alterar a situação das denúncias canceladas do usuário " do
        denuncia_cancelada = Factory.create(:denuncia_cancelada, :denunciante => denunciante_banivel)
        denunciante_banivel.banir
        Denuncia.find(denuncia_cancelada.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve alterar a situação das denúncias resolvidas do usuário " do
        denuncia_resolvida = Factory.create(:denuncia_resolvida, :denunciante => denunciante_banivel)
        denunciante_banivel.banir
        Denuncia.find(denuncia_resolvida.id).situacao.should == Denuncia::RESOLVIDA
      end
    end
    
    describe "#desistir" do
      context "deve desistir quando" do
        it "está com situação de CADASTRADO" do
          denunciante.desistir
          Denunciante.find(denunciante.id).situacao.should == Denunciante::DESISTENTE
        end
      end
      context "não deve desistir quando" do
        it "está com situação de BANIDO" do
          denunciante_banido = Factory.create :denunciante_banido
          denunciante_banido.desistir
          Denunciante.find(denunciante_banido.id).situacao.should == Denunciante::BANIDO
        end
        it "está com situação de DESISTENTE" do
          denunciante_desistente = Factory.create :denunciante_desistente
          denunciante_desistente.desistir
          Denunciante.find(denunciante_desistente.id).situacao.should == Denunciante::DESISTENTE
        end
      end
      it "deve cancelar todas as denúncias ativas do usuário" do
        denuncia_ativa = Factory.create(:denuncia, :denunciante => denunciante)
        denunciante.desistir
        Denuncia.find(denuncia_ativa.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve alterar a situação das denúncias rejeitadas do usuário" do
        denuncia_rejeitada = Factory.create(:denuncia_rejeitada, :denunciante => denunciante)
        denunciante.desistir
        Denuncia.find(denuncia_rejeitada.id).situacao.should == Denuncia::REJEITADA
      end
      it "não deve alterar a situação das denúncias canceladas do usuário" do
        denuncia_cancelada = Factory.create(:denuncia_cancelada, :denunciante => denunciante)
        denunciante.desistir
        Denuncia.find(denuncia_cancelada.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve alterar a situação das denúncias resolvidas do usuário" do
        denuncia_resolvida = Factory.create(:denuncia_resolvida, :denunciante => denunciante)
        denunciante.desistir
        Denuncia.find(denuncia_resolvida.id).situacao.should == Denuncia::RESOLVIDA
      end
    end
    
  end
  
end
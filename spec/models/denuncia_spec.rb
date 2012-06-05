require 'spec_helper'

describe Denuncia do
  
  let(:denuncia) {Factory.build :denuncia}
  let(:denuncia_ativa) {Factory.create :denuncia}
  let(:denuncia_rejeitada) {Factory.create :denuncia_rejeitada}
  let(:denuncia_cancelada) {Factory.create :denuncia_cancelada}
  let(:denuncia_resolvida) {Factory.create :denuncia_resolvida}
  
  describe "Relacionamentos" do
    it { should belong_to :denunciante }
  end
  
  describe "Escopo" do

    describe "#ativas" do
      it "deve retornar apenas denúncias ativas" do
        Denuncia.ativas.should include denuncia_ativa
        Denuncia.ativas.should_not include denuncia_rejeitada
        Denuncia.ativas.should_not include denuncia_cancelada
        Denuncia.ativas.should_not include denuncia_resolvida
      end
    end
    
    describe "#rejeitadas" do
      it "deve retornar apenas denúncias rejeitadas" do
        Denuncia.rejeitadas.should_not include denuncia_ativa
        Denuncia.rejeitadas.should include denuncia_rejeitada
        Denuncia.rejeitadas.should_not include denuncia_cancelada
        Denuncia.rejeitadas.should_not include denuncia_resolvida
      end
    end
    
    describe "#canceladas" do
      it "deve retornar apenas denúncias canceladas" do
        Denuncia.canceladas.should_not include denuncia_ativa
        Denuncia.canceladas.should_not include denuncia_rejeitada
        Denuncia.canceladas.should include denuncia_cancelada
        Denuncia.canceladas.should_not include denuncia_resolvida
      end
    end
    
    describe "#resolvidas" do
      it "deve retornar apenas denúncias resolvidas" do
        Denuncia.resolvidas.should_not include denuncia_ativa
        Denuncia.resolvidas.should_not include denuncia_rejeitada
        Denuncia.resolvidas.should_not include denuncia_cancelada
        Denuncia.resolvidas.should include denuncia_resolvida
      end
    end
    
  end
  
  describe "Métodos" do
    
    describe "#atribuir_valores_iniciais" do
      it "deve atribuir a situação de ATIVA se não especificado" do
        denuncia.situacao = nil
        denuncia.save
        denuncia.situacao.should == Denuncia::ATIVA
      end
      it "não deve atribuir a situação de ATIVA se uma válida for especificada" do
        denuncia.situacao = Denuncia::RESOLVIDA
        denuncia.save
        denuncia.situacao.should == Denuncia::RESOLVIDA
      end
      it "deve atribuir a DATA E HORA se não especificada" do
        denuncia.data_e_hora = nil
        denuncia.save
        denuncia.data_e_hora.should_not be_nil
      end
      it "não deve atribuir a DATA E HORA se uma válida for especificada" do
        ontem = Time.now-1.day
        denuncia.data_e_hora = ontem
        denuncia.save
        denuncia.data_e_hora.should == ontem
      end
    end
    
    describe "#ativa?" do
      context "deve retornar verdadeiro quando" do
        it "é uma denúncia ativa" do
          denuncia_ativa.ativa?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é uma denúncia rejeitada" do
          denuncia_rejeitada.ativa?.should be_false
        end
        it "é uma denúncia resolvida" do
          denuncia_resolvida.ativa?.should be_false
        end
        it "é uma denúncia cancelada" do
          denuncia_cancelada.ativa?.should be_false
        end
      end
    end
    
    describe "#reativavel?" do
      context "deve retornar verdadeiro quando" do
        it "é uma denúncia rejeitada" do
          denuncia_rejeitada.reativavel?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é uma denúncia ativa" do
          denuncia_ativa.reativavel?.should be_false
        end
        it "é uma denúncia resolvida" do
          denuncia_resolvida.reativavel?.should be_false
        end
        it "é uma denúncia cancelada" do
          denuncia_cancelada.reativavel?.should be_false
        end
      end
    end
    
    describe "#reativar" do
      it "deve reativar apenas uma denúncia rejeitada" do
        denuncia_rejeitada.reativar
        Denuncia.find(denuncia_rejeitada.id).situacao.should == Denuncia::ATIVA
      end
      it "não deve rejeitar uma denúncia ativa" do
        denuncia_ativa.reativar
        Denuncia.find(denuncia_ativa.id).situacao.should == Denuncia::ATIVA
      end
      it "não deve reativar uma denúncia cancelada" do
        denuncia_cancelada.reativar
        Denuncia.find(denuncia_cancelada.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve reativar uma denúncia resolvida" do
        denuncia_resolvida.reativar
        Denuncia.find(denuncia_resolvida.id).situacao.should == Denuncia::RESOLVIDA
      end
    end
    
    describe "#rejeitada?" do
      context "deve retornar verdadeiro quando" do
        it "é uma denúncia rejeitada" do
          denuncia_rejeitada.rejeitada?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é uma denúncia ativa" do
          denuncia_ativa.rejeitada?.should be_false
        end
        it "é uma denúncia resolvida" do
          denuncia_resolvida.rejeitada?.should be_false
        end
        it "é uma denúncia cancelada" do
          denuncia_cancelada.rejeitada?.should be_false
        end
      end
    end
    
    describe "#rejeitavel?" do
      context "deve retornar verdadeiro quando" do
        it "é uma denúncia ativa" do
          denuncia_ativa.rejeitavel?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é uma denúncia rejeitada" do
          denuncia_rejeitada.rejeitavel?.should be_false
        end
        it "é uma denúncia cancelada" do
          denuncia_cancelada.rejeitavel?.should be_false
        end
        it "é uma denúncia resolvida" do
          denuncia_resolvida.rejeitavel?.should be_false
        end
      end
    end
    
    describe "#rejeitar" do
      it "deve rejeitar apenas uma denúncia ativa" do
        denuncia_ativa.rejeitar
        Denuncia.find(denuncia_ativa.id).situacao.should == Denuncia::REJEITADA
      end
      it "não deve rejeitar uma denúncia rejeitada" do
        denuncia_rejeitada.rejeitar
        Denuncia.find(denuncia_rejeitada.id).situacao.should == Denuncia::REJEITADA
      end
      it "não deve rejeitar uma denúncia cancelada" do
        denuncia_cancelada.rejeitar
        Denuncia.find(denuncia_cancelada.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve rejeitar uma denúncia resolvida" do
        denuncia_resolvida.rejeitar
        Denuncia.find(denuncia_resolvida.id).situacao.should == Denuncia::RESOLVIDA
      end
    end
    
    describe "#cancelar" do
      it "deve cancelar apenas uma denúncia ativa" do
        denuncia_ativa.cancelar
        Denuncia.find(denuncia_ativa.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve cancelar uma denúncia rejeitada" do
        denuncia_rejeitada.cancelar
        Denuncia.find(denuncia_rejeitada.id).situacao.should == Denuncia::REJEITADA
      end
      it "não deve cancelar uma denúncia cancelada" do
        denuncia_cancelada.cancelar
        Denuncia.find(denuncia_cancelada.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve cancelar uma denúncia resolvida" do
        denuncia_resolvida.cancelar
        Denuncia.find(denuncia_resolvida.id).situacao.should == Denuncia::RESOLVIDA
      end
    end
    
    describe "#resolver" do
      it "deve resolver apenas uma denúncia ativa" do
        denuncia_ativa.resolver
        Denuncia.find(denuncia_ativa.id).situacao.should == Denuncia::RESOLVIDA
      end
      it "não deve resolver uma denúncia rejeitada" do
        denuncia_rejeitada.resolver
        Denuncia.find(denuncia_rejeitada.id).situacao.should == Denuncia::REJEITADA
      end
      it "não deve resolver uma denúncia cancelada" do
        denuncia_cancelada.resolver
        Denuncia.find(denuncia_cancelada.id).situacao.should == Denuncia::CANCELADA
      end
      it "não deve resolver uma denúncia resolvida" do
        denuncia_resolvida.resolver
        Denuncia.find(denuncia_resolvida.id).situacao.should == Denuncia::RESOLVIDA
      end
    end
    
  end
  
end
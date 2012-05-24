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
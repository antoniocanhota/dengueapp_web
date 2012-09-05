require 'spec_helper'

describe Usuario do
  
  let(:administrador) {(Factory.create :administrador).usuario}
  let(:moderador) {(Factory.create :moderador).usuario}
  let(:denunciante) {(Factory.create :denunciante_com_login).usuario}
  let(:usuario) {Factory.build :usuario}
  
  describe "Relacionamentos" do
    it { should have_one :denunciante }
    it { should have_one :operador }
  end
  
  describe "Validações" do
    
    describe "#nome" do
      it "deve ser obrigatório" do
        usuario.should validate_presence_of(:nome)
      end
    end
    
  end
  
  describe "Métodos" do
    
    describe "#administrador?" do
      context "deve retornar verdadeiro quando" do
        it "é um operador do tipo ADMINISTRADOR e está ATIVO" do
          administrador.administrador?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é um operador do tipo ADMINISTRADOR, mas está INATIVO" do
          administrador.operador.situacao = Operador::INATIVO
          administrador.administrador?.should be_false
        end
        it "é um operador do tipo ADMINISTRADOR, mas está PRÉ-CADASTRADO" do
          administrador.operador.situacao = Operador::PRECADASTRADO
          administrador.administrador?.should be_false
        end
        it "é um operador do tipo MODERADOR" do
          moderador.administrador?.should be_false
        end
        it "é um DENUNCIANTE" do
          denunciante.administrador?.should be_false
        end
      end
    end
    
    describe "#moderador?" do
      context "deve retornar verdadeiro quando" do
        it "é um operador do tipo MODERADOR e está ATIVO" do
          moderador.moderador?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é um operador do tipo MODERADOR, mas está INATIVO" do
          moderador.operador.situacao = Operador::INATIVO
          moderador.moderador?.should be_false
        end
        it "é um operador do tipo MODERADOR, mas está PRÉ-CADASTRADO" do
          moderador.operador.situacao = Operador::PRECADASTRADO
          moderador.moderador?.should be_false
        end
        it "é um operador do tipo ADMINISTRADOR" do
          administrador.moderador?.should be_false
        end
        it "é um DENUNCIANTE" do
          denunciante.moderador?.should be_false
        end
      end
    end
    
    describe "#denunciante?" do
      context "deve retornar verdadeiro quando" do
        it "é um denunicante e está CADASTRADO" do
          denunciante.denunciante?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é um denunciante, mas está BANIDO" do
          denunciante.denunciante.situacao = Denunciante::BANIDO
          denunciante.denunciante?.should be_false
        end
        it "é um denunciante, mas está DESISTENTE" do
          denunciante.denunciante.situacao = Denunciante::DESISTENTE
          denunciante.denunciante?.should be_false
        end
        it "é apenas um operador do tipo ADMINISTRADOR" do
          administrador.denunciante?.should be_false
        end
        it "é apenas um operador do tipo MODERADOR" do
          moderador.denunciante?.should be_false
        end
      end
    end
    
  end
  
end

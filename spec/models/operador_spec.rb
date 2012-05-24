require 'spec_helper'

describe Operador do
  
  let(:operador) {Factory.build :operador}
  let(:administrador_ativo) {Factory.create :administrador}
  let(:administrador_inativo) {Factory.create :administrador_inativo}
  let(:administrador_precadastrado) {Factory.create :administrador_precadastrado}
  let(:moderador_ativo) {Factory.create :moderador}
  let(:moderador_inativo) {Factory.create :moderador_inativo}
  let(:moderador_precadastrado) {Factory.create :moderador_precadastrado}
  
  describe "Relacionamentos" do
    it { should belong_to :usuario }
  end
  
  describe "Escopos" do
    
    
    describe "#adminitradores" do
      it "deve retornar administrador ativo" do
        Operador.administradores.should include administrador_ativo
      end
      it "deve retornar administrador pré-cadastrado" do
        Operador.administradores.should include administrador_precadastrado
      end
      it "não deve retornar administrador inativo" do
        Operador.administradores.should_not include administrador_inativo
      end
      it "não deve retornar moderador ativo" do
        Operador.administradores.should_not include moderador_ativo
      end
      it "não deve retornar moderador pré-cadastrado" do
        Operador.administradores.should_not include moderador_precadastrado
      end
      it "não deve retornar moderador inativo" do
        Operador.administradores.should_not include moderador_inativo
      end
    end
    
    describe "#moderadores" do
      it "não deve retornar administrador ativo" do
        Operador.moderadores.should_not include administrador_ativo
      end
      it "não deve retornar administrador pré-cadastrado" do
        Operador.moderadores.should_not include administrador_precadastrado
      end
      it "não deve retornar administrador inativo" do
        Operador.moderadores.should_not include administrador_inativo
      end
      it "deve retornar moderador ativo" do
        Operador.moderadores.should include moderador_ativo
      end
      it "deve retornar moderador pré-cadastrado" do
        Operador.moderadores.should include moderador_precadastrado
      end
      it "não deve retornar moderador inativo" do
        Operador.moderadores.should_not include moderador_inativo
      end
    end
    
    describe "#adminitradores_inclusive_inativos" do
      it "deve retornar administrador ativo" do
        Operador.administradores_inclusive_inativos.should include administrador_ativo
      end
      it "deve retornar administrador pré-cadastrado" do
        Operador.administradores_inclusive_inativos.should include administrador_precadastrado
      end
      it " deve retornar administrador inativo" do
        Operador.administradores_inclusive_inativos.should include administrador_inativo
      end
      it "não deve retornar moderador ativo" do
        Operador.administradores_inclusive_inativos.should_not include moderador_ativo
      end
      it "não deve retornar moderador pré-cadastrado" do
        Operador.administradores_inclusive_inativos.should_not include moderador_precadastrado
      end
      it "não deve retornar moderador inativo" do
        Operador.administradores_inclusive_inativos.should_not include moderador_inativo
      end
    end
    
    describe "#moderadores_inclusive_inativos" do
      it "não deve retornar administrador ativo" do
        Operador.moderadores_inclusive_inativos.should_not include administrador_ativo
      end
      it "não deve retornar administrador pré-cadastrado" do
        Operador.moderadores_inclusive_inativos.should_not include administrador_precadastrado
      end
      it "não deve retornar administrador inativo" do
        Operador.moderadores_inclusive_inativos.should_not include administrador_inativo
      end
      it "deve retornar moderador ativo" do
        Operador.moderadores_inclusive_inativos.should include moderador_ativo
      end
      it "deve retornar moderador pré-cadastrado" do
        Operador.moderadores_inclusive_inativos.should include moderador_precadastrado
      end
      it "deve retornar moderador inativo" do
        Operador.moderadores_inclusive_inativos.should include moderador_inativo
      end
    end
    
    describe "#administradores_inativos" do
      it "não deve retornar administrador ativo" do
        Operador.administradores_inativos.should_not include administrador_ativo
      end
      it "não deve retornar administrador pré-cadastrado" do
        Operador.administradores_inativos.should_not include administrador_precadastrado
      end
      it "deve retornar administrador inativo" do
        Operador.administradores_inativos.should include administrador_inativo
      end
      it "não deve retornar moderador ativo" do
        Operador.administradores_inativos.should_not include moderador_ativo
      end
      it "não deve retornar moderador pré-cadastrado" do
        Operador.administradores_inativos.should_not include moderador_precadastrado
      end
      it "deve retornar moderador inativo" do
        Operador.administradores_inativos.should_not include moderador_inativo
      end
    end
    
    describe "#moderadores_inativos" do
      it "não deve retornar administrador ativo" do
        Operador.moderadores_inativos.should_not include administrador_ativo
      end
      it "não deve retornar administrador pré-cadastrado" do
        Operador.moderadores_inativos.should_not include administrador_precadastrado
      end
      it "não deve retornar administrador inativo" do
        Operador.moderadores_inativos.should_not include administrador_inativo
      end
      it "não deve retornar moderador ativo" do
        Operador.moderadores_inativos.should_not include moderador_ativo
      end
      it "não deve retornar moderador pré-cadastrado" do
        Operador.moderadores_inativos.should_not include moderador_precadastrado
      end
      it "deve retornar moderador inativo" do
        Operador.moderadores_inativos.should include moderador_inativo
      end
    end
    
  end
  
  describe "Métodos" do
    
    describe "#atribuir_valores_iniciais" do
      it "deve atribuir a situação de CADASTRADO se não especificado" do
        operador.situacao = nil
        operador.save
        Operador.find(operador.id).situacao.should == Operador::ATIVO
      end
      it "não deve atribuir a situação de ATIVA se uma válida for especificada" do
        operador.situacao = Operador::INATIVO
        operador.save
        Operador.find(operador.id).situacao.should == Operador::INATIVO
      end
    end

    describe "#moderador?" do
      context "deve retornar verdadeiro quando" do
        it "é do tipo MODERADOR" do
          moderador_ativo.moderador?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "é do tipo ADMINISTRADOR" do
          administrador_ativo.moderador?.should be_false
        end
      end
    end
    
    describe "#ativo?" do
      context "deve retornar verdadeiro quando" do
        it "está com situação ATIVO" do
          moderador_ativo.ativo?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "está com situação INATIVO" do
          moderador_inativo.ativo?.should be_false
        end
        it "está com situação PRE-CADASTRADO" do
          moderador_precadastrado.ativo?.should be_false
        end
      end
    end
    
    describe "#inativo?" do
      context "deve retornar verdadeiro quando" do
        it "está com situação INATIVO" do
          moderador_inativo.inativo?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "está com situação ATIVO" do
          moderador_ativo.inativo?.should be_false
        end
        it "está com situação PRE-CADASTRADO" do
          moderador_precadastrado.inativo?.should be_false
        end
      end
    end
    
    describe "#precadastrado?" do
      context "deve retornar verdadeiro quando" do
        it "está com situação PRE-CADASTRADO" do
          moderador_precadastrado.precadastrado?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "está com situação INATIVO" do
          moderador_inativo.precadastrado?.should be_false
        end
        it "está com situação ATIVO" do
          moderador_ativo.precadastrado?.should be_false
        end
      end
    end
    
    describe "#desativavel?" do
      context "deve retornar verdadeiro quando" do
        it "é MODERADOR e está com situação PRE-CADASTRADO" do
          moderador_precadastrado.desativavel?.should be_true
        end
        it "é MODERADOR e está com situação ATIVO" do
          moderador_ativo.desativavel?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "está com situação INATIVO, independentemente de seu tipo" do
          moderador_inativo.desativavel?.should be_false
        end
        it "é do tipo ADMINISTRADOR" do
          administrador_inativo.desativavel?.should be_false
        end
      end
    end
    
    describe "#desativar" do
      context "deve desativar quando" do
        it "é desativável" do
          moderador_ativo.desativar.should be_true
        end
      end
      context "não deve desativar quando" do
        it "não é desativável" do
          moderador_inativo.desativar.should_not be_true
        end
      end
      it "deve alterar o status para INATIVO" do
        moderador_ativo.desativar
        Operador.find(moderador_ativo.id).situacao.should == Operador::INATIVO
      end
    end
    
    describe "#ativavel?" do
      context "deve retornar verdadeiro quando" do
        it "é MODERADOR e está com situação INATIVO" do
          moderador_inativo.ativavel?.should be_true
        end
      end
      context "deve retornar falso quando" do
        it "está com situação ATIVO, independentemente de seu tipo" do
          moderador_ativo.ativavel?.should be_false
        end
        it "é do tipo ADMINISTRADOR" do
          administrador_inativo.ativavel?.should be_false
        end
      end
    end
    
    describe "#ativar" do
      context "deve ativar quando" do
        it "é ativável" do
          moderador_inativo.ativar.should be_true
        end
      end
      context "não deve ativar quando" do
        it "não é ativável" do
          moderador_ativo.ativar.should_not be_true
        end
      end
      it "deve alterar o status para ATIVO" do
        moderador_inativo.ativar
        Operador.find(moderador_inativo.id).situacao.should == Operador::ATIVO
      end
    end
    
  end
  
end
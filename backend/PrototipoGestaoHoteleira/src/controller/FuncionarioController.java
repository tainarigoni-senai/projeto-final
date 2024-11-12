package controller;

import enumeration.Funcionalidade;
import exception.FuncionarioException;
import model.Funcionario;
import test.FuncionarioTest;

import java.text.ParseException;

public class FuncionarioController {

    // Atributos
    private FuncionarioTest funcionarioTest;

    // Construtor que inicializa a instância de FuncionarioTest
    public FuncionarioController(FuncionarioTest funcionarioTest) {
        this.funcionarioTest = funcionarioTest;
    }

    // Método para gerenciar e executar testes conforme a funcionalidade
    public String testar(Funcionalidade funcionalidade) throws FuncionarioException, ParseException {
        switch (funcionalidade){
            case LISTAR :
                return funcionarioTest.listar(); // Chama o teste de listagem
            case CADASTRAR:
                return funcionarioTest.cadastrar(); // Chama o teste de cadastro
            case ALTERAR:
                return funcionarioTest.atualizar(); // Chama o teste de atualização
            case EXCLUIR:
                return funcionarioTest.excluir(); // Chama o teste de exclusão
            default:
                return null; // Retorna null para funcionalidades desconhecidas
        }
    }
}

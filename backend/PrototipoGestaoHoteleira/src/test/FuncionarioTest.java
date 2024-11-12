package test;

import exception.FuncionarioException;
import exception.PessoaException;
import model.Funcionario;
import service.FuncionarioService;
import service.PessoaService;

import java.text.ParseException;

public class FuncionarioTest {

    // Serviço de funcionários usado nos testes
    private FuncionarioService funcionarioService;

    // Construtor
    // Construtor que inicializa o serviço de funcionários
    public FuncionarioTest(FuncionarioService funcionarioService) {
        this.funcionarioService = funcionarioService;
    }

    // Métodos de testes
    // Método para listar todos os funcionários
    public String listar() throws FuncionarioException, ParseException {
        return funcionarioService.listar();
    }
    // Método para cadastrar um novo funcionário
    public String cadastrar() throws FuncionarioException {
        return funcionarioService.cadastrar(
                "Sasá",
                "04/07/2004",
                "123",
                "Brasil",
                "SC",
                "Tubarão",
                "RH",
                1200.00
        );
    }
    // Método para atualizar dados de um funcionário existente
    public String atualizar() throws FuncionarioException {
        return funcionarioService.alterar(
                8L,                     // ID do funcionário
                "Nova Sasa 2.0",        // Novo nome
                "01/10/2000",           // Nova data de nascimento
                "456",                  // Novo código de identificação
                "z2",                   // Novo país
                "z3",                   // Novo estado
                "z4",
                "FAXINEIRO",
                4000.00
        );
    }
    // Método para excluir um funcionário pelo ID
    public String excluir() throws FuncionarioException {
        return funcionarioService.excluir(17L);
    }
}
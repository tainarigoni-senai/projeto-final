import controller.FuncionarioController;
import controller.PessoaController;
import dao.FuncionarioDAO;
import dao.PessoaDAO;
import enumeration.Funcionalidade;
import exception.FuncionarioException;
import exception.PessoaException;
import model.Funcionario;
import service.FuncionarioService;
import service.PessoaService;
import test.FuncionarioTest;
import test.PessoaTest;

public class Principal {

    public static void main(String[] args) throws Exception {
        // Inicialização de objetos
        PessoaDAO pessoaDAO = new PessoaDAO();
        PessoaService pessoaService = new PessoaService(pessoaDAO);
        PessoaTest pessoaTest = new PessoaTest(pessoaService);
        PessoaController pessoaController = new PessoaController(pessoaTest);

        FuncionarioDAO funcionarioDao = new FuncionarioDAO();
        FuncionarioService funcionarioService = new FuncionarioService(funcionarioDao);
        FuncionarioTest funcionarioTest = new FuncionarioTest(funcionarioService);
        FuncionarioController funcionarioController = new FuncionarioController(funcionarioTest);

        // Informações do teste
        Funcionalidade funcionalidade = Funcionalidade.ALTERAR;
        System.out.println("FUNCIONARIO: " + funcionalidade);
        System.out.println("RESULTADO DO TESTE:");

        // Realização do teste
        try {
            System.out.println(funcionarioController.testar(funcionalidade));
        } catch(FuncionarioException excecao) {
            System.err.println(excecao.getMessage());
        }
    }

}

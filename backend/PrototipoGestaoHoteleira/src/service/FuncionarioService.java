package service;

import dao.FuncionarioDAO;
import enumeration.Funcionalidade;
import exception.FuncionarioException;
import exception.PessoaException;
import model.Funcionario;
import model.Pessoa;
import util.Util;

import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;

public class FuncionarioService {

    // Atributos
    // DAO de funcionários para acessar o banco de dados
    private FuncionarioDAO funcionarioDAO;

    // Construtor
    // Construtor que inicializa o DAO de funcionários
    public FuncionarioService(FuncionarioDAO funcionarioDAO) {
        this.funcionarioDAO = funcionarioDAO;
    }

    // Método para listar todos os funcionários
    public String listar() throws FuncionarioException, ParseException {
        ArrayList<Funcionario> funcionarios = funcionarioDAO.selecionar();
        String lista = "";
        if (funcionarios.size()>0){
            for (Funcionario funcionario : funcionarios){
                lista += funcionario + "\n";
            }
        }else{
            lista = "Nenhuma pessoa encontrada.";
        }
        return lista;
    }

    // Método para cadastrar um novo funcionário
    public String cadastrar(
            String nomeCompleto,
            String dataNascimentoFormatoBR,
            String documento,
            String pais,
            String estado,
            String cidade,
            String cargo,
            Double salario
    ) throws FuncionarioException {
        // Valida campos obrigatórios para o cadastro
        String mensagemErro = validarCampos(Funcionalidade.CADASTRAR, null, nomeCompleto, dataNascimentoFormatoBR, documento, cargo);
        if(!mensagemErro.equals("")) throw new FuncionarioException(mensagemErro);

        LocalDate dataNascimento = Util.formatarStringParaLocalDate(dataNascimentoFormatoBR);
        Pessoa pessoa = new Pessoa(
                nomeCompleto,
                dataNascimento,
                documento,
                pais,
                estado,
                cidade
        );
        Funcionario funcionario = new Funcionario(
                nomeCompleto,
                dataNascimento,
                documento,
                pais,
                estado,
                cidade,
                cargo,
                salario
        );

        // Insere o funcionário no banco de dados
        if(funcionarioDAO.inserir(funcionario)) {
            return "Funcionario cadastrada com sucesso!";
        } else {
            throw new FuncionarioException("Não foi possível cadastrar a pessoa! Por favor, tente novamente.");
        }
    }

    // Método para alterar dados de um funcionário existente
    public String alterar(
            Long id,
            String nomeCompleto,
            String dataNascimentoFormatoBR,
            String documento,
            String pais,
            String estado,
            String cidade,
            String cargo,
            Double salario
    ) throws FuncionarioException{
        // Valida campos obrigatórios para a alteração
        String mensagemErro = validarCampos(Funcionalidade.ALTERAR, id, nomeCompleto, dataNascimentoFormatoBR, documento, cargo);
        if(!mensagemErro.equals("")) throw new FuncionarioException(mensagemErro);

        Funcionario funcionarioAlteracao = funcionarioDAO.selecionarPorId(id);

        LocalDate dataNascimento = Util.formatarStringParaLocalDate(dataNascimentoFormatoBR);
        Funcionario funcionario = new Funcionario(
                id,
                nomeCompleto,
                dataNascimento,
                documento,
                pais,
                estado,
                cidade,
                funcionarioAlteracao.getIdPessoa(),
                cargo,
                salario
        );

        // Atualiza o funcionário no banco de dados
        if(funcionarioDAO.atualizar( funcionario)) {
            return "Pessoa alterada com sucesso!";
        } else {
            throw new FuncionarioException("Não foi possível alterar a pessoa!! Por favor, tente novamente.");
        }
    }

    // Método para excluir um funcionário pelo ID
    public String excluir(Long id)throws FuncionarioException{
        String mensagemErro = validarCampos(Funcionalidade.EXCLUIR,id,null,null,null,null);
        if (!mensagemErro.equals(""))throw new FuncionarioException(mensagemErro);

        // Remove o funcionário do banco de dados
        if (funcionarioDAO.deletar(id)){
            return "Funcionario excluído com sucesso!";
        }else{
            throw new FuncionarioException("Não foi possível excluir o funcionario! Por favor tente novamente.");
        }
    }

    // Método privado para validar campos obrigatórios conforme a funcionalidade

    private String validarCampos(
            Funcionalidade funcionalidade,
            Long id,
            String nomeCompleto,
            String dataNascimentoFormatoBR,
            String documento,
            String cargo
    ) throws FuncionarioException {
        String erros = "";
        // Verifica se o ID é necessário para alterar ou excluir
        if(funcionalidade == Funcionalidade.ALTERAR || funcionalidade == Funcionalidade.EXCLUIR) {
            if(id == null) {
                erros += "\n- Id é obrigatório.";
            } else if(funcionarioDAO.selecionarPorId(id) == null) {
                erros += "\n- Id não encontrado.";
            }
        }
        // Valida campos específicos para cadastro e alteração
        if(funcionalidade == Funcionalidade.CADASTRAR || funcionalidade == Funcionalidade.ALTERAR) {
            // Nome completo
            if(nomeCompleto == null || nomeCompleto.trim().equals("")) {
                erros += "\n- Nome completo é obrigatório.";
            }
            // Data de nascimento
            if(dataNascimentoFormatoBR == null || dataNascimentoFormatoBR.trim().equals("")) {
                erros += "\n- Data de nascimento é obrigatória.";
            } else if(!Util.validarDataFormatoBR(dataNascimentoFormatoBR)) {
                erros += "\n- Data de nascimento inválida.";
            }
            // Documento
            if(documento == null || documento.trim().equals("")) {
                erros += "\n- Documento é obrigatório.";
            }
            // Cargo
            if(cargo == null || cargo.trim().equals("")) {
                erros += "\n- Cargo é obrigatório.";
            }
        }

        // Monta a mensagem de erro se houver campos inválidos
        String mensagemErro = "";
        if(!erros.equals("")) {
            mensagemErro = "Não foi possível " + funcionalidade.name().toLowerCase() + " o funcionario! " +
                    "Erro(s) encontrado(s):" + erros;
        }
        return mensagemErro;
    }

}

package br.com.redesocial.modelo.dao;

import br.com.redesocial.modelo.dto.Usuario;
import br.com.redesocial.modelo.dto.enumeracoes.Sexo;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/**
 * Objeto de acesso aos dados dos usuários
 * @author Ronneesley Moura Teles, Lucas Azevedo
 * @since 27/07/2017
 */
public class UsuarioDAO extends DAOCRUDBase<Usuario> {
    
    /**
    * Método responsável pela inserção de um objeto no banco de dados na tabela usuários
    * @param dto objeto com os dados de usuário já preenchido
    * @throws Exception
    */
    @Override
    public void inserir(Usuario dto) throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement pstmt = conexao.prepareStatement("insert into usuarios(nome, email, telefone, senha, data_nascimento, sexo, data_cadastro, status, foto, cidade) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
        
        pstmt.setString(1, dto.getNome());
        pstmt.setString(2, dto.getEmail());
        pstmt.setString(3, dto.getTelefone());
        pstmt.setString(4, dto.getSenha());
        pstmt.setDate(5, new java.sql.Date(dto.getDataNascimento().getTime()));
        pstmt.setString(6, String.valueOf(dto.getSexo().getId()));
        pstmt.setDate(7, new java.sql.Date(dto.getDataCadastro().getTime()));
        pstmt.setBoolean(8, dto.getStatus());
        
        if (dto.getFoto() != null){
            pstmt.setInt(9, dto.getFoto().getId());
        } else {
            pstmt.setNull(9, Types.BLOB);
        }
        
        
        pstmt.setInt(10, dto.getCidade().getId()); 
       
        /**
      * executa uma inserção
      */
        pstmt.executeUpdate();
        
        dto.setId(getId(pstmt));
    }

    /**
    * Método que seleciona um usuário já cadastrado no banco de dados
    * @param id identificador do usuário
    * @return u usuário selecionado no banco de dados
    * @throws Exception possíveis exceções que podem acontecer
    */
    @Override
    public Usuario selecionar(int id) throws Exception {
        Connection conexao = getConexao();

        PreparedStatement  pstmt; 
        pstmt = conexao.prepareStatement("select * from usuarios where id = ?");
        pstmt.setInt(1, id);

        ResultSet rs;
        rs = pstmt.executeQuery();

        MultimidiaDAO multimidiaDAO = new MultimidiaDAO();
        CidadeDAO cidadeDAO = new CidadeDAO();
        if (rs.next()){
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setNome(rs.getString("nome"));
            u.setEmail(rs.getString("email"));
            u.setTelefone(rs.getString("telefone"));
            u.setSenha(rs.getString("senha"));
            u.setDataNascimento(rs.getDate("data_nascimento"));            
            u.setSexo(Sexo.getSexo(rs.getString("sexo").charAt(0)));
            u.setDataCadastro(rs.getDate("data_cadastro"));
            u.setStatus(rs.getBoolean("status"));
            u.setFoto(multimidiaDAO.selecionar(rs.getInt("foto")));
            u.setCidade(cidadeDAO.selecionar(rs.getInt("cidade")));

            return u;
        }else{
            return null;
        }
    }  
    
    /**
    * Método responsável pela alteração de dados de um usuário no banco de dados
    * @author Lucas Azevedo
    * @param u novos dados alterado do usuário, com o ID do usuário a ser alterado preenchido
    * @throws Exception possíveis exceções que podem acontecer
    */
    @Override
    public void alterar (Usuario  u) throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement  pstmt; 
        
        pstmt = conexao.prepareStatement("update usuarios set nome = ?, email=?, telefone=?, senha =?, data_nascimento =?, sexo = ?, data_cadastro =?, status =?, foto=?, cidade=? where id =? ");
       
        pstmt.setString(1, u.getNome());
        pstmt.setString(2, u.getEmail());
        pstmt.setString(3, u.getTelefone());
        pstmt.setString(4, u.getSenha());  
        pstmt.setDate(5, new java.sql.Date(u.getDataNascimento().getTime()));
        pstmt.setString(6, String.valueOf(u.getSexo().getId()));
        pstmt.setDate(7, new java.sql.Date(u.getDataCadastro().getTime()));
        pstmt.setBoolean(8, u.getStatus());
        
        if (u.getFoto() != null){
            pstmt.setInt(9, u.getFoto().getId());
        } else {
            pstmt.setNull(9, Types.BLOB);
        }
        
        pstmt.setInt(10, u.getCidade().getId()); 
        pstmt.setInt(11, u.getId());          
        
     /**
      * executa uma atualização/alteração
      */
        pstmt.executeUpdate();
    }
    
    /**
     * Método responsável pela alteração da senha de um usuário
     * @author Lara Caroline
     * @param u nova senha do usuário, com o ID do usuário, a ser alterado, preenchido
     * @throws Exception possíveis exceções que podem acontecer
     */    
    public void alterarSenha (Usuario  u) throws Exception {
        Connection conexao = getConexao();

        PreparedStatement  pstmt; 
        pstmt = conexao.prepareStatement("update usuarios set senha = ? where id = ?");
       
        pstmt.setString(1, u.getSenha()); 
        pstmt.setInt(2, u.getId());
       
        pstmt.executeUpdate();
    }
    
    /**
     * Método que lista todos os usuários em ordem alfabética cadastrados no banco de dados
     * @author Adallberto Lucena Moura
     * @return lista de usuários ordenados alfabeticamente
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
     public List listar() throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement  pstmt; 
        pstmt = conexao.prepareStatement("select * from usuarios order by nome asc");
                
        ResultSet rs;
        rs = pstmt.executeQuery();
        
	MultimidiaDAO multimidiaDAO = new MultimidiaDAO();
        CidadeDAO cidadeDAO = new CidadeDAO();
        List lista;
        lista = new ArrayList();
        
        while (rs.next()){
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setNome(rs.getString("nome"));
            u.setEmail(rs.getString("email"));
            u.setTelefone(rs.getString("telefone"));
            u.setSenha(rs.getString("senha"));
            u.setDataNascimento(rs.getDate("data_nascimento"));            
            u.setSexo(Sexo.getSexo(rs.getString("sexo").charAt(0)));
            u.setDataCadastro(rs.getDate("data_cadastro"));
            u.setStatus(rs.getBoolean("status"));
            u.setFoto(multimidiaDAO.selecionar(rs.getInt("foto")));
            u.setCidade(cidadeDAO.selecionar(rs.getInt("cidade")));
            
            lista.add(u);
        }
        
        return lista;
    }

    /**
    * Método responsável pela exclusão de um usuário no banco de dados
    * @param id identificador do usuário a ser excluído
    * @throws Exception possíveis exceções que podem acontecer
    */
    @Override
    public void excluir(int id) throws Exception {
        Connection conexao = getConexao();  
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("delete from usuarios where id = ?");
        pstmt.setInt(1, id);
        pstmt.executeUpdate();

    }

    /**
    * Método responsável pelo login do usuário
    * @param email identificador do email a ser usado no login
    * @param senha identificador da senha a ser usada no login
    * @return u com os dados do usuário que coindidir com os parâmetros
    * @throws Exception possíveis exceções que podem acontecer
    */
    public Usuario logar(String email, String senha) throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement  pstmt; 
        pstmt = conexao.prepareStatement("select * from usuarios where email = ? and senha = ?");
        pstmt.setString(1, email);
        pstmt.setString(2, senha);
        
        ResultSet rs;
        rs = pstmt.executeQuery();

        if (rs.next()){
            MultimidiaDAO multimidiaDAO = new MultimidiaDAO();
            CidadeDAO cidadeDAO = new CidadeDAO();
            
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setNome(rs.getString("nome"));
            u.setEmail(rs.getString("email"));
            u.setTelefone(rs.getString("telefone"));
            u.setSenha(rs.getString("senha"));
            u.setDataNascimento(rs.getDate("data_nascimento"));            
            u.setSexo(Sexo.getSexo(rs.getString("sexo").charAt(0)));
            u.setDataCadastro(rs.getDate("data_cadastro"));
            u.setStatus(rs.getBoolean("status"));
            u.setFoto(multimidiaDAO.selecionar(rs.getInt("foto")));
            u.setCidade(cidadeDAO.selecionar(rs.getInt("cidade")));

            return u;
        }else{
            return null;
        }
    } 

    /**
    * Método responsável pela seleção do email do usuário para usar no envio de email
    * @param email identificador do email a ser usado
    * @return u com os dados do usuário que coindidir com o email
    * @throws Exception possíveis exceções que podem acontecer
    */
    public Usuario selecionarEmail(String email) throws Exception {
        
        Connection conexao = getConexao();

        PreparedStatement  pstmt; 
        pstmt = conexao.prepareStatement("select * from usuarios where email = ?");
        pstmt.setString(1, email);

        ResultSet rs;
        rs = pstmt.executeQuery();
	
        MultimidiaDAO multimidiaDAO = new MultimidiaDAO();
        CidadeDAO cidadeDAO = new CidadeDAO();        
        
        if (rs.next()){
            Usuario u = new Usuario();
            u.setId(rs.getInt("id"));
            u.setNome(rs.getString("nome"));
            u.setEmail(rs.getString("email"));
            u.setTelefone(rs.getString("telefone"));
            u.setSenha(rs.getString("senha"));
            u.setDataNascimento(rs.getDate("data_nascimento"));            
            u.setSexo(Sexo.getSexo(rs.getString("sexo").charAt(0)));
            u.setDataCadastro(rs.getDate("data_cadastro"));
            u.setStatus(rs.getBoolean("status"));
            u.setFoto(multimidiaDAO.selecionar(rs.getInt("foto")));
            u.setCidade(cidadeDAO.selecionar(rs.getInt("cidade")));
            return u;
        }else{
            return null;
        }
    }
}

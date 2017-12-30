package br.com.redesocial.modelo.dao;

import br.com.redesocial.modelo.dto.Postagem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * @author IgorRodrigues, JonathanSilvestre
 */
public class PostagemDAO extends DAOCRUDBase<Postagem> {
    
    /**
     * Método responsável por excluir uma postagem do banco de dados
     * @author Igor Justino Rodrigues
     * @param id da postagem a ser excluida
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public void excluir(int id) throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("delete from postagens where id = ?");
        
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
    }

    @Override
    public void inserir(Postagem p) throws Exception {
        Connection conexao = getConexao();
        if (p.getDescricao().equals("")){
            throw new Exception("A descricao nao pode estar vazia!");
        }
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("insert into postagens (ups,downs,descricao,data, usuario, visualizacoes) values (?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
        
        pstmt.setInt(1, p.getUps());
        pstmt.setInt(2, p.getDowns());
        pstmt.setString(3,p.getDescricao());
        pstmt.setTimestamp(4, new Timestamp(p.getData().getTime()));
        pstmt.setInt(5, p.getUsuario().getId());
        pstmt.setInt(6, p.getVisualizacoes());
        
        pstmt.executeUpdate();
        
        p.setId(getId(pstmt));
    }
    
    /**
     * Método responsável pela alteração de uma postagem no banco de dados
     * @author Igor Justino Rodrigues
     * @param p novos dados de postagem, com o ID da postagem a ser alterado já preenchido
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public void alterar(Postagem p) throws Exception{
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("update postagens set ups = ?, downs = ?, descricao = ?, data = ?, usuario = ? where id = ?");
        
        pstmt.setInt(1, p.getUps());
        pstmt.setInt(2, p.getDowns());
        pstmt.setString(3, p.getDescricao());
        pstmt.setDate(4, new java.sql.Date(p.getData().getTime()));
        pstmt.setInt(5, p.getUsuario().getId());
        pstmt.setInt(6, p.getId());
        
        pstmt.executeUpdate();
    }
    
    /**
     * Método responsável por selecionar uma postagem no banco de dados
     * @author Igor Justino Rodrigues
     * @param id da postagem a ser selecionada
     * @return a postagem selecionada
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public Postagem selecionar(int id) throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("select * from postagens where id = ?");
        
        pstmt.setInt(1, id);
        ResultSet rs = pstmt.executeQuery();
        
        if(rs.next()){
            Postagem p = new Postagem();
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            
            //SETA DADOS NA ENTIDADE DE POSTAGEM
            p.setId(rs.getInt("id"));
            p.setUps(rs.getInt("ups"));
            p.setDowns(rs.getInt("downs"));
            p.setDescricao(rs.getString("descricao"));
            p.setVisualizacoes(rs.getInt("visualizacoes"));
            p.setData(rs.getDate("data"));
            
            //PEGA O USUÁRIO
            p.setUsuario(usuarioDAO.selecionar(rs.getInt("usuario")));
            
            //RETORNA A IDENTIDADE DE POSTAGEM
            return p;
        } else {
            return null;
        }
    }
    
    /**
     * Método que lista todos os comentários ordenado pela data.
     * @author Paulo Henrique Araujo.
     * @return lista.
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public List listar() throws Exception {
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("select * from postagens order by data desc");
        ResultSet rs;
        rs = pstmt.executeQuery();
        
        List lista;
        lista = new ArrayList();
        
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        while(rs.next()){
            Postagem p = new Postagem();
            p.setId(rs.getInt("id"));
            p.setUps(rs.getInt("ups"));
            p.setDowns(rs.getInt("downs"));
            p.setDescricao(rs.getString("descricao"));
            p.setData(rs.getDate("data"));
            p.setUsuario(usuarioDAO.selecionar(rs.getInt("usuario")));
            lista.add(p);
        }
        
        return lista;
     
    }
}

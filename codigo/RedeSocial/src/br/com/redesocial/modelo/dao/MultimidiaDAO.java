package br.com.redesocial.modelo.dao;

import java.sql.ResultSet;
import br.com.redesocial.modelo.dto.Multimidia;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lara, Jeferson, Luciano, Jonathan
 */
public class MultimidiaDAO extends DAOCRUDBase<Multimidia> {
    
    /**
     * Método responsável pela inserção de uma multimídia no banco de dados
     * @param m da multimídia a ser inserida
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public void inserir(Multimidia m) throws Exception {
        Connection conexao = getConexao();
        
        //Arrumar as validações
        if (m.getMidia().equals("")){
            throw new Exception("A mídia não pode estar vazia!");
        }
                
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("insert into multimidias(midia, tipo_conteudo, data, album) values(?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);

        pstmt.setBytes (1, m.getMidia());
        pstmt.setString (2, m.getTipoConteudo());
        pstmt.setTimestamp(3, new java.sql.Timestamp(m.getData().getTime()));
        pstmt.setInt (4, m.getAlbum().getId());
        
        pstmt.executeUpdate();
        
        m.setId(getId(pstmt));
    }
    
    /**
     * Método que seleciona uma multimídia já cadastrada no banco de dados
     * @author Lara Caroline
     * @param id identificador da mídia
     * @return Multimídia selecionada no banco de dados
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public Multimidia selecionar(int id) throws Exception{
        Connection conexao = getConexao();

        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("select * from multimidias where id = ?");
        pstmt.setInt(1, id);

        ResultSet rs;
        rs = pstmt.executeQuery();

        if (rs.next()){
            Multimidia m = new Multimidia();
            m.setId(rs.getInt("id"));
            m.setMidia(rs.getBytes("midia"));
            m.setTipoConteudo(rs.getString("tipo_conteudo"));
            m.setData(rs.getTimestamp("data"));

            return m;
        } else {
            return null;
        }
    }

    /**
     * Método responsável pela exclusão da multimídia no banco de dados
     * @param id identificador da multimídia a ser excluída
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public void excluir(int id) throws Exception {
        Connection conexao = getConexao();

        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("delete from multimidias where id = ?");

        pstmt.setInt(1, id);
        pstmt.executeUpdate();
    }
    
    /**
     * Método que lista todas as multimídias em ordem descrecem por data do banco de dados
     * @author Luciano de Carvalho Borba
     * @return lista as multimídias em ordem descrescente por data
     * @throws Exception possíveis exceções que podem acontecer
     */
    @Override
    public List listar() throws Exception  {
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("select * from multimidias order by data desc");
        
        ResultSet rs;
        rs = pstmt.executeQuery();
        
        List lista;
        lista = new ArrayList();
        
        while (rs.next()){
            Multimidia m = new Multimidia();
            m.setId(rs.getInt("id"));
            m.setMidia(rs.getBytes("midia"));
            m.setTipoConteudo(rs.getString("tipo_conteudo"));
            m.setData(rs.getTimestamp("data"));
            lista.add(m);
        }
        
        return lista;
    }
    
    /**
    * Método que Altera todas as multimídias  no banco de dados
    * @author Jose Gilvan Jacinto Junior
    * @param m as multimídias a serem alteradas
    * @throws Exception possíveis exceções que podem acontecer
    */
    @Override
    public void alterar(Multimidia m) throws Exception { 
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("update multimidias set midia = ?, tipo_conteudo = ?, data = ?, album = ?, where id = ?");
        
        
        pstmt.setBytes(1, m.getMidia());
        pstmt.setString(2, m.getTipoConteudo());
        pstmt.setTimestamp(3, new java.sql.Timestamp(m.getData().getTime()));
        pstmt.setInt(4, m.getAlbum().getId());
        
        
        //executa uma atualização/alteração
        pstmt.executeUpdate();
    }

    /**
     * Método que lista todas as multimídias existentes no banco pesquisado
     * @return lista as multimídias existentes no álbum pesquisado
     * @param id o álbum a ser pesquisado
     * @throws Exception possíveis exceções que podem acontecer
     */
    public List listarMultimidiasAlbum(int id) throws Exception{
        Connection conexao = getConexao();
        
        PreparedStatement pstmt;
        pstmt = conexao.prepareStatement("select * from multimidias where album = ? ");
        
        pstmt.setInt(1, id);
        
        ResultSet rs;
        rs = pstmt.executeQuery();
        
        List lista;
        lista = new ArrayList();
        
        while (rs.next()){
            Multimidia m = new Multimidia();
            m.setId(rs.getInt("id"));
            m.setMidia(rs.getBytes("midia"));
            m.setTipoConteudo(rs.getString("tipo_conteudo"));
            m.setData(rs.getTimestamp("data"));
            lista.add(m);
        }
        
        return lista;
    }
}
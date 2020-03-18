package dao;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import conexao.Conecta;
import dados.*;
public class Candidatodao extends Conecta {
	
	public int gravar(Candidato c )
	{
		
		int id_candidato = 0;
		try

		{
			String sql = null;
			sql = ("insert into candidato (id_cargo,numinscricao,nomecandidato,genero,nacionalidade,estadocivil,datanasc,idade,rgnumero,rgOrgao,rguf,rgdata,cpf,cnh,deficiencia,defqual,endereco,numero,bairro,uf,cidade,cep,email,fone,atesto,dataregistro,categoria)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			//sql = ("insert into candidato (id_candidato,id_cargo,numinscricao,nomecandidato,genero,nacionalidade,estadocivil,datanasc,idade,rgnumero,rgOrgao,rguf,rgdata,cpf,cnh,deficiencia,defqual,endereco,numero,bairro,uf,cidade,cep,email,fone,atesto)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			//stm =  con.prepareStatement(sql);
			stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			//stm.setInt(1,c.getId_candidato());
			stm.setInt(1,c.getId_cargo());
			stm.setString(2,c.getNuminscricao()); 		
			stm.setString(3,c.getNomecandidato()); 		
			stm.setString(4,c.getGenero()); 				
			stm.setString(5,c.getNacionalidade()); 		
			stm.setString(6,c.getEstadocivil()); 		
			stm.setString(7,c.getDatanasc()); 			
			stm.setString(8,c.getIdade()); 	
			stm.setString(9,c.getRgnumero()); 
			stm.setString(10,c.getRgorgao());				
			stm.setString(11,c.getRgdata()); 				
			stm.setString(12,c.getRguf()); 				
			stm.setString(13,c.getCpf()); 				
			stm.setString(14,c.getCnh()); 				
			stm.setString(15,c.getDeficiencia()); 		
			stm.setString(16,c.getDefqual()); 			
			stm.setString(17,c.getEndereco()); 			
			stm.setString(18,c.getNumero()); 				
			stm.setString(19,c.getBairro()); 				
			stm.setString(20,c.getUf());					
			stm.setString(21,c.getCidade()); 				
			stm.setString(22,c.getCep()); 				
			stm.setString(23,c.getEmail()); 				
			stm.setString(24,c.getFone());  				
			stm.setString(25,c.getAtesto()); 
			stm.setString(26,c.getDataregistro());  				
			stm.setString(27,c.getCategoria()); 
			
			stm.executeUpdate();
		
			
			try (ResultSet generatedKeys = stm.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                id_candidato = generatedKeys.getInt(1);
	                //user.setId(generatedKeys.getLong(1));
	                System.out.println("ID candidato: " + id_candidato);
	            }
	            else {
	                throw new SQLException("Creating user failed, no ID obtained.");
	            }
	        }
		
			stm.close();                             
			con.close();
		}
		catch(SQLException erroSQL) /* erro no banco de dados */
		{
			System.out.println("Erro de conexão com o banco de dados , erro"+erroSQL);
		} 
		
		return id_candidato;


	}
	
	
	


}

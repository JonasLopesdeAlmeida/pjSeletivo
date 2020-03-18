package dao;

import java.sql.SQLException;

import conexao.Conecta;
import dados.Uploade;


public class Uploadedao extends Conecta {
	
	
	public void gravar(Uploade u )
	{
	
		
		try

		{

			
			stm =  con.prepareStatement("insert into upload(id_cargo,id_candidato,id_doc,file,pontuacao,dataregistro)values(?,?,?,?,?,?)");
			stm.setInt(1,u.getId_cargo());
			stm.setInt(2,u.getId_candidato());
			stm.setInt(3,u.getId_doc());
			stm.setString(4,u.getFile());
			stm.setInt(5,u.getPontuacao());
			stm.setString(6,u.getDataregistro());
		
			stm.execute();
			stm.close();                             
			con.close();
		}
		catch(SQLException erroSQL) /* erro no banco de dados */
		{
			System.out.println("Erro de conexão com o banco de dados , erro"+erroSQL);
		} 


	}
	
	
	public void atualizar(Uploade u )
	{

		try

		{

			stm =  con.prepareStatement("update upload set pontuacao = ? where id_upload = ?");
			stm.setInt(1,u.getPontuacao());
			stm.setInt(2,u.getId_upload());
			stm.executeUpdate();
			stm.close();
			con.close();
		}
		catch(SQLException erroSQL) /* erro no banco de dados */
		{
			System.out.println("Erro de conexão com o banco de dados , erro"+erroSQL);
		} 


	}
	
	
	

//	public Uploade buscarPorId(int id) {
//		Uploade uploade = new Uploade();
//		try
//
//		{
//
//			stm =  con.prepareStatement("select * from upload where id_doc = ?");
//			stm.setInt(1,id);
//			uploade = (Uploade) stm.executeQuery();
//			stm.close();
//			con.close();
//		}
//		catch(SQLException erroSQL) /* erro no banco de dados */
//		{
//			System.out.println("Erro de conexão com o banco de dados , erro"+erroSQL);
//		} 
//		
//		return uploade;
//		
//	}
	
	

}

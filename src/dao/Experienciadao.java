package dao;

import java.sql.SQLException;
import conexao.Conecta;
import dados.Experiencia;


public class Experienciadao extends Conecta 
{

	
	
	public void gravar(Experiencia e )
	{
	
		
		try

		{

			stm =  con.prepareStatement("insert into experiencia(id_candidato,local,cargo,tempo)values(?,?,?,?)");
			stm.setInt(1,e.getId_candidato());
			stm.setString(2,e.getLocal());
			stm.setString(3,e.getCargo());
			stm.setString(4,e.getTempo());
		
			stm.execute();
			stm.close();                             
			con.close();
		}
		catch(SQLException erroSQL) /* erro no banco de dados */
		{
			System.out.println("Erro de conexão com o banco de dados , erro"+erroSQL);
		} 


	}
}

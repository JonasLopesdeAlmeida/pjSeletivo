package dao;
import java.sql.SQLException;

import conexao.Conecta;
import dados.Cargo;

public class Cargodao extends Conecta {
	
	public void gravar(Cargo c )
	{

		try

		{

			stm =  con.prepareStatement("insert into curso(descricao,observacao)values(?,?)");
			stm.setString(1,c.getDescricao());
			stm.setString(2,c.getObservacao());
		
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

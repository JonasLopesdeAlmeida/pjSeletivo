package conexao;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Conecta {

	protected static Connection con ;
	protected static PrintWriter out;
	protected static PreparedStatement stm ;
	protected static ResultSet rs ;
   
     public void open()
     {
     		try
     		{
            Class.forName("org.postgresql.Driver");
     		con = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo","postgres","252107");
     		
 	}
	     		 catch (SQLException e) 
	     		 {
	     			e.printStackTrace();
				 }
	     		 catch(ClassNotFoundException erroClass) /*erro caso ele não localize a classe o driver*/
	     	 	 {
	     	 	
			
     }
		

}
}

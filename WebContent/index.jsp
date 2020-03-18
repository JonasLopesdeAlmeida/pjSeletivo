
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>

<%@page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
  <!-- Meta tags Obrigatórias -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="shortcut icon" href="/favicon/favicon.ico">
  <link rel="icon" sizes="16x16 32x32 64x64" href="/favicon/favicon.ico">
  <title>PROCESSO SELETIVO - SEMED</title>
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

</head>

<body class="bg-white">
  <div class="py-5 text-center" style="	background-image: url(imgs/alunos.jpg);	background-size: cover;	background-position: top left;	background-repeat: repeat;">
    <div class="container">
      <div class="row">
        <div class="shadow-lg mb-5 bg-white rounded p-5 mx-auto col-md-8 col-8">
          <div class="col-12 px-2 col-md-12">
            <img class="img-fluid" src="imgs/logo3.png">
          </div>
          <p class="mb-3 lead">SECRETARIA MUNICIPAL DE EDUCAÇÃO</p>
          <h3 class="mb-2">Processo Seletivo Simplificado 001/2020</h3>
        </div>
      </div>
    </div>
  </div>
  <br><br>
      <div class="row">
        
        <div class="col-md-6 py-2 mx-auto">
          <p>            
            <button class="btn btn-success btn-lg btn-block text-white" type="button" data-toggle="collapse" data-target="#collInscrições" aria-expanded="false" aria-controls="collInscrições">
              Avaliação
            </button>
          </p>
          <div class="collapse bg-success text-white" id="collInscrições">            
            <div class="card card-body bg-success">
              <h3>
                Selecione o cargo ao qual deseja realizar sua inscrição
              </h3>
              <div class="list-group">  
		<%    


				     PreparedStatement ps= null;
				 	 Connection con = null;
				 	 ResultSet rs = null;
				 	 SimpleDateFormat dateFormat = null;
 	  		{
 	 
 			 try
 	 			{
		 	      Class.forName("org.postgresql.Driver").newInstance();
		 	      con = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo","postgres","252107");
		 	      ps = con.prepareStatement("select * from cargo order by id_cargo");
		 	    // ps = con.prepareStatement("select curso.id_curso,curso.descricao as descricao,id_aluno,nome,endereco,bairro,cep,fone,rg,cpf,datanasc,nomepai,nomemae,email,naturalidade,uf,documentos,situacao,data from aluno  inner join curso on curso.id_curso = aluno.id_curso where nome like ?  order by nome limit 5 offset " + offset);
		 	     // ps.setInt(1,'%'+id_cargo+'%');
		 	      rs = ps.executeQuery();
		 	      while(rs.next())
      			{
 	     
           %>           
                            
               <a href="consultaDoc.jsp?id_cargo=<%= rs.getInt("id_cargo")%>" class="list-group-item list-group-item-action"><%= rs.getString("descricao")%></a>
               
          <%                  
      		}
 	 	
		}
	catch(ClassNotFoundException erroClass) /*erro caso ele não localize a classe o driver*/
 	{
 	out.println("Classe Driver JDBC não foi localizado, erro "+erroClass);
 	}

 	 catch(SQLException erroSQL) /* erro no banco de dados */
 	 {
 	 out.println("Erro de conexão com o banco de dados , erro"+erroSQL);
 	 } 
 	 finally
          {
        	  if(rs!= null)rs.close();
        	  if(ps!= null)ps.close();
        	  if(con!= null)con.close();
          }
 	  }
		
 	%>    
             
             
             
             
              </div>          
            </div>
          </div>
        </div>




      </div>
      
      
      
      <div class="row">
        
      </div>
    </div>
  </div>
  <!-- JavaScript (Opcional) -->
  <!-- jQuery primeiro, depois Popper.js, depois Bootstrap JS, depois Fontsawesome -->  
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  <script src="https://kit.fontawesome.com/907f5688d2.js"></script>
</body>

</html>
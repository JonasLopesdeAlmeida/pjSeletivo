<%@page import="dados.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>

<%@page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" errorPage="" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">

     <!-- Meta tags Obrigatórias -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="shortcut icon" href="/favicon/favicon.ico">
    <link rel="icon" sizes="16x16 32x32 64x64" href="/favicon/favicon.ico">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

    <link rel="stylesheet" href="css/stylo.css">

    <title>PROCESSO SELETIVO - SEMED</title>

  </head>
  <body class="bg-light">
      <section id="header">
          <div class="container py-2 bg-white">
              <div class="row text-center">
                  <div class="col-12 px-2">
                    <img class="img-responsive" src="imgs/logo3.png">
                  </div>
                  <div class="col-12">
                    <h3>SECRETARIA MUNICIPAL DE EDUCAÇÃO</h3>
                    <h4 class="text-light bg-primary py-2">FORMULÁRIO DE INSCRIÇÃO ON-LINE</h4>
                    <h3 class="text-warning">UPLOAD DE DOCUMENTOS</h3>
                  </div>
              </div>
          </div>
      </section>
      <section>
      
     <%
Date dataAtual = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
String dataStr = sdf.format(dataAtual);
%> 	
 <form action="ServerUploade" method="post" enctype="multipart/form-data">
               <input type="hidden" class="form-control" id="dataregistro" name="dataregistro" value="<%= dataStr%>">
                 
              <%    
int id_candidato =Integer.parseInt(request.getParameter("id_candidato"));
              

        	
		if(id_candidato != 0)
		{
      
			  PreparedStatement ps= null;
		 	  Connection con = null;
		 	  ResultSet rs = null;
		 	 SimpleDateFormat dateFormat = null;
		 	  {
		 	 
		 	 try
		 	 	{
		  Class.forName("org.postgresql.Driver").newInstance();
		  con = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo","postgres","252107");
 	      ps= con.prepareStatement("select cargo.descricao as descricao,* from candidato inner join cargo on  candidato.id_cargo = cargo.id_cargo where id_candidato = ?");
 	    // ps= con.prepareStatement("select * from candidato  where nomecandidato like ?");
 	      ps.setInt(1, id_candidato);
 	      rs = ps.executeQuery();
 	      ps.clearParameters();
 	      if(rs.next())
       		{
           %>
             
			<div class="container py-2 bg-white">
              <div class="row">
                    <dt class="col-sm-2">CARGO:</dt>
                    
                   
                    <input type="hidden" class="form-control" id="id_candidato" name="id_candidato" value="<%= rs.getInt("id_candidato")%>">
                     <input type="hidden" class="form-control" id="id_cargo" name="id_cargo" value="<%= rs.getInt("id_cargo")%>">

                    <dd class="col-sm-10 text-primary"><%= rs.getString("descricao")%></dd>                    
                    <dt class="col-sm-2">Nº DE INSCRIÇÃO:</dt>
                    <dd class="col-sm-10 text-primary"><%= rs.getString("numinscricao")%><%= rs.getInt("id_candidato")%></dd>
                    <dt class="col-sm-2">CANDIDATO:</dt>
                    <dd class="col-sm-10 text-primary"><%= rs.getString("nomecandidato")%></dd>
                   </div>
          </div> 
                    
           
              
      </section>
      <section id="documentos">
          <div class="container py-3 bg-white">
              <div class="row">
              		<div class="col-12">
              			<p>
              				<strong class="text-danger">*</strong> Campos Obrigatórios.<br>
              				<strong>(c)</strong> Campos para classificação.
              			</p>
              		</div>
                  <div class="col-12">
                    <hr>
                   
                        <div class="form-row">
                        
                         <%    
                        
int recebe_cargo = rs.getInt("id_cargo");
int num = 1;          

        	
		if(recebe_cargo != 0)
		{
      
			  PreparedStatement ps1= null;
		 	  Connection con1 = null;
		 	  ResultSet rs1 = null;

		 	  {
		 	 
		 	 try
		 	 	{
		  Class.forName("org.postgresql.Driver").newInstance();
		  con1 = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo","postgres","252107");
 	     // ps1= con1.prepareStatement("select * from documento where id_cargo = ? order by id_doc");
 	      ps1= con1.prepareStatement("select * from documento inner join cargo on cargo.id_cargo = documento.id_cargo where documento.id_cargo = ? order by id_doc");
 	      ps1.setInt(1, recebe_cargo);
 	      rs1 = ps1.executeQuery();
 	      ps1.clearParameters();
 	      while(rs1.next())
       		{
           %>  
                        <div class="form-group">
                        	<div class="row">
                         		<input type="hidden" class="form-control" id="id_doc<%= rs1.getInt("id_doc")%>" name="id_doc<%= rs1.getInt("id_doc")%>" value="<%= rs1.getInt("id_doc")%>">
                        		<label class="col-md-12"><%out.println(num++);%> - <%= rs1.getString("descricao_doc")%><%= rs1.getInt("id_doc")%> <strong class="text-danger"><%= rs1.getString("tipo")%></strong></label>
                        		<input type="file" class="form-control-file col-md-12" id="exampleFormControlFile1" name="file">
								<input type="hidden" class="form-control" id="id_doc" name="pontuacao" value="<%= rs1.getInt("pontuacao")%>">
                        	</div>
						 </div>
               
               
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
		        	  if(rs1!= null)rs1.close();
		        	  if(ps1!= null)ps1.close();
		        	  if(con1!= null)con1.close();
		          }
		 	  }
		}
%>              

                        </div>
                        <div class="form-group text-center">
                        	<button class="btn btn-outline-primary"><i class="fas fa-check"></i> Enviar Arquivos</button>                        	
                        </div>
                                      
                    </form>
                  </div>
                  
                  
                  
              </div>
           
              
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
		}
%>       
              
          </div>
      </section>
    

    <!-- JavaScript (Opcional) -->
    <!-- jQuery primeiro, depois Popper.js, depois Bootstrap JS, depois Fontsawesome -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://kit.fontawesome.com/907f5688d2.js"></script>
  </body>
</html>
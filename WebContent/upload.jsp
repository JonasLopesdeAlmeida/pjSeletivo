<%@page import="dados.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>

<%@page contentType="text/html; charset=ISO-8859-1" language="java"
	pageEncoding="UTF-8" import="java.sql.*" errorPage=""%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<META http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-- Meta tags Obrigatórias -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="shortcut icon" href="/favicon/favicon.ico">
<link rel="icon" sizes="16x16 32x32 64x64" href="/favicon/favicon.ico">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

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
					<h4 class="text-light bg-primary py-2">FORMULÁRIO DE INSCRIÇÃO
						ON-LINE</h4>
					<h3 class="text-warning">UPLOAD DE DOCUMENTOS</h3>
				</div>
			</div>
		</div>
	</section>
	<section>


		

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
					<%
Date dataAtual = new Date(); 
SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
String dataStr = sdf.format(dataAtual);
%>
		<form action="Server" method="post" enctype="multipart/form-data">
		<input type="hidden" class="form-control" id="id_candidato"
						name="id_candidato" value="<%= rs.getInt("id_candidato")%>">
					<input type="hidden" class="form-control" id="id_cargo"
						name="id_cargo" value="<%= rs.getInt("id_cargo")%>">
			<input type="hidden" class="form-control" id="dataregistro"
				name="dataregistro" value="<%= dataStr%>">
						<div class="form-row">
							<div class="form-group col-md-12">
								<label for="tipoDoc">TIPO DE DOCUMENTO:</label>
								
								 <select id="tipoDoc" name="id_doc" class="form-control" required>
									<option selected></option>
									<%    
                        
int recebe_cargo = rs.getInt("id_cargo");
int num = 0;          

        	
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
									
									<option class="text-success" value="<%= rs1.getInt("id_doc")%>"><%= rs1.getString("descricao_doc")%><strong
											class="text-danger"><%= rs1.getString("tipo")%></strong></option>

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
								</select>
								
							</div>



							<div class="form-group col-md-10">
								<label for="uploadDoc">UPLOAD DE DOCUMENTOS:</label>
								<div class="form-row">
									<div class="col-md-10">
										<input type="file" name="file" class="form-control-file"
											id="uploadDoc" required>
									</div>
									<input type="hidden" class="form-control" id="pontuacao"
										name="pontucao" value="<%= num%>">
									<div class="col-md-2">
										<button type="submit" class="btn btn-outline-success">
											<i class="fas fa-check"></i>
										</button>
									</div>
								</div>
							</div>



						</div>
					</form>
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
			<div class="row">
				<div class="col-md-12 py-3">
					<hr>
					<h3>DOCUMENTOS ENVIADOS:</h3>
					<%    
                        
int recebe_candidato = Integer.parseInt(request.getParameter("id_candidato"));
//int num1 = 0;
///num1++;

        	
		if(recebe_candidato != 0)
		{
      
			  PreparedStatement ps2= null;
		 	  Connection con2 = null;
		 	  ResultSet rs2 = null;

		 	  {
		 	 
		 	 try
		 	 	{
		  Class.forName("org.postgresql.Driver").newInstance();
		  con2 = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo","postgres","252107");
 	     // ps1= con1.prepareStatement("select * from documento where id_cargo = ? order by id_doc");
 	      ps2= con2.prepareStatement("select documento.id_doc as id_doc,documento.descricao_doc as descricao_doc,id_candidato from upload	 inner join documento on documento.id_doc = upload.id_doc where id_candidato=?");
 	      ps2.setInt(1, recebe_candidato);
 	      rs2 = ps2.executeQuery();
 	      ps2.clearParameters();
 	      while(rs2.next())
       		{
           %>

					<ul class="list-unstyled">
						<li><i class="fas fa-check text-success"></i><%= rs2.getString("descricao_doc")%></li>

					</ul>
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
		        	  if(rs2!= null)rs2.close();
		        	  if(ps2!= null)ps2.close();
		        	  if(con2!= null)con2.close();
		          }
		 	  }
		}
%>

				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<%    
//int id_candidato =Integer.parseInt(request.getParameter("id_candidato"));

              

        	
		//if(id_candidato != 0)
	//	{
      
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


					<a class="btn btn-primary"
						href="experiencia.jsp?id_candidato=<%= rs.getInt("id_candidato")%>">Experiência</a>

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
		//}
%>


			</div>
		</div>

	</section>




	<!-- JavaScript (Opcional) -->
	<!-- jQuery primeiro, depois Popper.js, depois Bootstrap JS, depois Fontsawesome -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/907f5688d2.js"></script>
</body>
</html>
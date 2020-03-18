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
              
      </section>
      <section id="documentos">
          <div class="container py-3 bg-white">
            
            <div class="container">
            
            
        		<%
			int id_candidato = Integer.parseInt(request.getParameter("id_candidato"));
		

			if (id_candidato != 0) {

				PreparedStatement ps = null;
				Connection con = null;
				ResultSet rs = null;

			
					try {
						Class.forName("org.postgresql.Driver").newInstance();
						con = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo", "postgres","252107");
						ps = con.prepareStatement("select * from candidato where id_candidato = ?");
						ps.setInt(1,id_candidato);
						rs = ps.executeQuery();
						if(rs.next()) {
						
		%>
		<br> 
		<h2 style="text-align: center">Cadastro Efetuado Com Sucesso!</h2>
		<hr>
		<h1 style="text-align: center">SEMED20200<%=rs.getInt("id_candidato")%></h1><br>
		<h1 style="text-align: center"><%=rs.getString("nomecandidato")%></h1>
		<h3 style="text-align: center"><%=rs.getString("dataregistro")%></h3>
		<hr>
		

		
		<%
			}

					} catch (ClassNotFoundException erroClass) /*erro caso ele não localize a classe o driver*/
					{
						out.println("Classe Driver JDBC não foi localizado, erro " + erroClass);
					}

					catch (SQLException erroSQL) /* erro no banco de dados */
					{
						out.println("Erro de conexão com o banco de dados , erro" + erroSQL);
					} finally {
						if (rs != null)
							rs.close();
						if (ps != null)
							ps.close();
						if (con != null)
							con.close();
					}
				}
			
		%>

		
                    
 
</div>
<div class="container py-3 bg-white">
              <div class="row">                
                  <div class="col-12 text-center">
                      <form>
                        <input type="button" class="btn btn-success" name="imprimir" value="Imprimir Página" onclick="window.print();">
                      </form>
                  </div>
              </div>
          </div>
            
            
            
              
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
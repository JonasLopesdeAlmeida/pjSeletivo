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
                    <h3 class="text-danger">EXPERIÊNCIA PROFISSIONAL</h3>
                  </div>
              </div>
          </div>
      </section>
     
      <section id="documentos">
          <div class="container py-3 bg-white">
              <div class="row">                
                  <div class="col-12">
                    <form action="ServerUploadeAtualiza" method="post">
      
       <%    
int id_candidato = Integer.parseInt(request.getParameter("id_candidato"));
              

        	
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
 	      ps.setInt(1,id_candidato);
 	      rs = ps.executeQuery();
 	      ps.clearParameters();
 	      if(rs.next())
       		{
           %>   	<div class="container py-2 bg-white">
              <div class="row">
                    
                    <input type="hidden" class="form-control" id="id_candidato" name="id_candidato" value="<%= rs.getInt("id_candidato")%>">  
                    <input type="hidden" class="form-control" id="id_cargo" name="id_cargo" value="<%= rs.getInt("id_cargo")%>"> 
                    <dt class="col-sm-3">CARGO:</dt>
                    <dd class="col-sm-9 text-primary"><%= rs.getString("descricao")%></dd>               
                    <dt class="col-sm-3">Nº DE INSCRIÇÃO:</dt>
                    <dd class="col-sm-9 text-primary"><%= rs.getString("numinscricao")%><%= rs.getInt("id_candidato")%></dd>
                    <dt class="col-sm-3">CANDIDATO:</dt>
                    <dd class="col-sm-9 text-primary"><%= rs.getString("nomecandidato")%></dd>
                   </div>
          </div> 
                    
        <select id="tipoDoc" name="id_doc" class="form-control" required>
           <option selected></option>
		 	
		 	    <%    
                        
int recebe_cargo = rs.getInt("id_candidato");
        

        	
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
 	      //ps= con.prepareStatement("select cargo.descricao as descricao,* from candidato inner join cargo on  candidato.id_cargo = cargo.id_cargo where nomecandidato like ?");
 	    // ps1= con1.prepareStatement("select * from documento where id_cargo = ?");
 	  //  ps1= con1.prepareStatement("select * from documento where id_cargo = ? and  tipo = '(c)' and criterio <> 'Cert'");
 	   ps1= con1.prepareStatement("select distinct * from upload,documento where upload.id_doc = documento.id_doc and documento.tipo = '(c)' and documento.criterio <> 'Cert' and upload.id_candidato = ?");
 	   
 	      ps1.setInt(1, recebe_cargo);
 	      rs1 = ps1.executeQuery();
 	      ps1.clearParameters();
 	      int i = 0;
 	      while(rs1.next())
       		{
           %>    
           
           
 <option class="text-success"  value="<%= rs1.getInt("id_doc")%>"><%= rs1.getInt("id_upload")%><%= rs1.getString("descricao_doc")%><%= rs1.getInt("id_doc")%><strong class="text-danger"><%= rs1.getString("tipo")%></strong></option>

                            
                        </div>    
                        
                        
                        
                                                   
                        <div class="form-group col-md-2">
                        
                          <label for="tempoTrabalho"><%= rs1.getString("indicador")%>:(<%= rs1.getString("txt_criterio")%>)</label>
      </select>
     </div>                       
                          <!-- CASO 1 quando indicador igua a tempo -->
                          <select id="indicador" name="pontuacao<%= i%>" class="form-control" required>
                            <option selected></option>
<%    
int recebe_doc = rs1.getInt("id_doc");
		if(recebe_doc != 0)
		{
      
			  PreparedStatement ps2= null;
		 	  Connection con2 = null;
		 	  ResultSet rs2 = null;

		 	  {
		 	 
		 	 try
		 	 	{
				  Class.forName("org.postgresql.Driver").newInstance();
				  con2 = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo","postgres","252107");
		 	      ps2= con2.prepareStatement("select * from indicador where id_doc = ? ");
			      ps2.setInt(1, recebe_doc);
		 	      rs2 = ps2.executeQuery();
		 	      ps2.clearParameters();
		 	      while(rs2.next())
       			{
 %>
                            <option class="text-success"  value="<%= rs2.getInt("pontos")%>"><%= rs2.getString("seletor")%></option>
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
		 	  
		 	  i++;
		}
%>                                   
            
                          </select>
                        
                     
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
                      
                      
                      
                      
                      
                      <div class="form-row">
                        <div class="col-md-12 text-center">
                            <button type="submit" class="btn btn-outline-success"><i class="fas fa-check"></i> Incluir</button>
                        </div>                        
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
              
              
              
                        
  
              <!-- Modal -->
                <div class="modal fade" id="modalExcluir" tabindex="-1" role="dialog" aria-labelledby="modalExcluir" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                        <h5 class="modal-title" id="modalExcluir">Exclusão</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        </div>
                        <div class="modal-body">
                        Deseja excluir a experência profissional?
                        </div>
                        <div class="modal-footer">
                            <div class="col-md-12 text-center">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-danger"><i class="fas fa-eraser"></i> Excluir</button>
                            </div>
                        </div>
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
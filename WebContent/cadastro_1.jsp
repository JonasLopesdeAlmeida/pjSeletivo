<%@page import="dados.*"%>
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
<META http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link rel="shortcut icon" href="/favicon/favicon.ico">
    <link rel="icon" sizes="16x16 32x32 64x64" href="/favicon/favicon.ico">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">

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
                <h4 class="text-light bg-primary">FORMULÁRIO DE INSCRIÇÃO ON-LINE</h4>
              </div>
          </div>
      </div>
    </section>
      <section id="cadastro">
          <div class="container py-3 bg-white">
            
              <div class="row">
                  <div class="col-12">
                    <form action="ServerCandidato" method="post">
                    <div class="row">
                    	<%    
int id_cargo =Integer.parseInt(request.getParameter("id_cargo"));	

String nome = "semmed20200";
int num = 1;

		if(id_cargo != 0)
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
 	      ps= con.prepareStatement("select * from cargo where id_cargo=?");
 	      ps.setInt(1,id_cargo);
 	      rs = ps.executeQuery();
 	      ps.clearParameters();
 	      if(rs.next())
       		{
           %>  
           

              			<div class="form-group col-md-12">
                        <label for="nInscricao" class="text-primary">CARGO:</label>
                        <input type="text" class="form-control text-primary" id="descricao" name="descricao" value="<%= rs.getString("descricao")%>" disabled>
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
                        <div class="form-row">                          
                            <div class="form-group col-md-2">
                              <label for="nInscricao">Nº INSCRIÇÃO:</label>
                              <input type="text" value="<%= nome %><%= num++ %>" class="form-control" id="nInscricao" readonly="true" name="numinscricao"  >
                            </div>                            
                            <div class="form-group col-md-10">
                              <label for="nomeCandidato">NOME DO CANDIDATO:</label>
                              <input type="text" class="form-control" id="nomeCandidato"  name="nomecandidato" required>
                            </div>                            
                        </div>                   
                        
                        <div class="form-row">
                          <div class="form-group col-md-3">
                              <label for="nomeCandidato">GÊNERO: </label>
                                <div class="custom-control custom-radio">
                                  <input class="custom-control-input" type="radio" name="genero" id="genero1"  
                                   <%
						if (request.getAttribute("genero") != null) {
							 Candidato candidato = (Candidato) request.getAttribute("genero");
								if(candidato.constroiGenero("Maculino") ){
							out.print("checked=\"checked\"");
							 out.print(" ");
						 }
						}
						%>
						value="Maculino">
                        <label class="custom-control-label" for="genero1">Maculino</label>
                                </div>
                                <div class="custom-control custom-radio">
                                  <input class="custom-control-input" type="radio" name="genero" id="genero2" 
                                    <%
						if (request.getAttribute("genero") != null) {
							 Candidato candidato = (Candidato) request.getAttribute("genero");
								if(candidato.constroiGenero("Feminino") ){
							out.print("checked=\"checked\"");
							 out.print(" ");
						 }
						}
						%>
						value="Feminino">
                       <label class="custom-control-label" for="genero2">Feminino</label>
                                </div>
                                <div class="custom-control custom-radio">
                                  <input class="custom-control-input" type="radio" name="genero" id="genero3" 
                                  <%
						if (request.getAttribute("genero") != null) {
							 Candidato candidato = (Candidato) request.getAttribute("Outros");
								if(candidato.constroiGenero("Outros") ){
							out.print("checked=\"checked\"");
							 out.print(" ");
						 }
						}
						%>
						value="Outros">
                         <label class="custom-control-label" for="genero3">Outros</label>
                              </div>
                          </div>
                          <div class="form-group col-md-3">
                              <label for="nomeCandidato">NACIONALIDADE: </label>
                                <div class="custom-control custom-radio">
                                  <input class="custom-control-input" type="radio" name="nacionalidade" id="nacionalidade1" value="B" checked>
                                  <label class="custom-control-label" for="nacionalidade1">Brasileira</label>
                                </div>
                                <div class="custom-control custom-radio">
                                  <input class="custom-control-input" type="radio" name="nacionalidade" id="nacionalidade2" value="E">
                                  <label class="custom-control-label" for="nacionalidade2">Estrangeira</label>
                                </div>                                
                          </div>
                          <div class="form-group col-md-2">
                            <label for="EstadoCivil">ESTADO CIVIL:</label>
                            <select id="EstadoCivil"  name="estadocivil" class="form-control" required>
                              <option selected>Escolher...</option>
                              <option>Solteiro(a)</option>
                              <option>Casado(a)</option>
                              <option>Divorciado(a)</option>
                              <option>Viúvo(a)</option>
                              <option>Separado(a)</option>
                               <option>Outro</option>
                            </select>
                          </div>
                          <div class="form-group col-md-3">
                            <label for="DataNascimento">DT/NASCIMENTO:</label>
                            <input type="date" name="datanasc" class="form-control" id="DataNascimento" required>
                          </div>                          
                          <div class="form-group col-md-1">
                            <label for="idade">IDADE:</label>
                            <input type="number" name="idade" class="form-control" id="idade" required>
                          </div>
                        </div>
                        
                        <div class="form-row">
                          <div class="form-group col-md-3">
                            <label for="rgNumero">RG nº:</label>
                            <input type="text" class="form-control" name="" id="rgNumero" required>
                          </div>
                          <div class="form-group col-md-5">
                            <label for="rgOrgao">RG Órgão Expedidor:</label>
                            <input type="text" name="rgOrgao" class="form-control" id="rgOrgao" required>
                          </div>
                          <div class="form-group col-md-1">
                            <label for="rgUf">UF:</label>
                            <select id="rgUf" name="rgUf" class="form-control" required>
                              <option selected> </option>
                              <option>AC</option>
                              <option>AL</option>
                              <option>AM</option>
                              <option>AP</option>
                              <option>BA</option>
                              <option>CE</option>
                              <option>DF</option>
                              <option>ES</option>
                              <option>GO</option>
                              <option>MA</option>
                              <option>MG</option>
                              <option>MS</option>
                              <option>MT</option>
                              <option>PA</option>
                              <option>PB</option>
                              <option>PE</option>
                              <option>PI</option>
                              <option>PR</option>
                              <option>RJ</option>
                              <option>RN</option>
                              <option>RO</option>
                              <option>RR</option>
                              <option>RS</option>
                              <option>SC</option>
                              <option>SE</option>
                              <option>SP</option>
                              <option>TO</option>
                            </select>
                          </div>                          
                          <div class="form-group col-md-3">
                            <label for="rgData">RG Data Expedição:</label>
                            <input type="date" name="rgData" class="form-control" id="rgData" required>
                          </div>
                        </div>

                        <div class="form-row">                          
                          <div class="form-group col-md-2">
                            <label for="cpf">Nº CPF:</label>
                            <input type="text" name="cpf"class="form-control" id="cpf" required>
                          </div>                          
                          <div class="form-group col-md-2">
                            <label for="cnh">Nº CNH:</label>
                            <input type="text" name="cnh"class="form-control" id="cnh">
                          </div>
                          <div class="form-group col-md-3">
                            <label for="nomeCandidato">PESSOA COM DEFICIÊNCIA: </label>                                                          
                              <div class="custom-control custom-radio">
                                <input type="radio" id="def1" name="deficiencia" class="custom-control-input">
                                <label class="custom-control-label" for="def1">Sim</label>
                              </div>
                              <div class="custom-control custom-radio">
                                <input type="radio" id="def2" name="deficiencia" class="custom-control-input" checked>
                                <label class="custom-control-label" for="def2">Não</label>
                              </div>                              
                          </div>                          
                          <div class="form-group col-md-5">
                            <label for="defQual">Qual deficiência?</label>
                            <input type="text" name="defQual" class="form-control" id="defQual">                             
                          </div>
                        </div>

                        <div class="form-row">
                          <div class="form-group col-md-6">
                            <label for="logradouro">ENDEREÇO: Logradouro: </label>
                            <input type="text" name="endereco" class="form-control" id="logradouro" required>
                          </div>
                          <div class="form-group col-md-1">
                            <label for="endNumero">Número: </label>
                            <input type="text" name="numero" class="form-control" id="endNumero">
                          </div>
                          <div class="form-group col-md-5">
                            <label for="bairo">Bairro: </label>
                            <input type="text" name="bairro" class="form-control" id="bairro" required>
                          </div>                          
                        </div>                        
                        <div class="form-row">
                          <div class="form-group col-md-4">
                            <label for="cidade">Cidade</label>
                            <input type="text" name="cidade" class="form-control" id="cidade" required>
                          </div>
                          <div class="form-group col-md-1">
                            <label for="endUf">UF:</label>
                            <select id="endUf" name="uf" class="form-control" required>
                              <option selected> </option>
                              <option>AC</option>
                              <option>AL</option>
                              <option>AM</option>
                              <option>AP</option>
                              <option>BA</option>
                              <option>CE</option>
                              <option>DF</option>
                              <option>ES</option>
                              <option>GO</option>
                              <option>MA</option>
                              <option>MG</option>
                              <option>MS</option>
                              <option>MT</option>
                              <option>PA</option>
                              <option>PB</option>
                              <option>PE</option>
                              <option>PI</option>
                              <option>PR</option>
                              <option>RJ</option>
                              <option>RN</option>
                              <option>RO</option>
                              <option>RR</option>
                              <option>RS</option>
                              <option>SC</option>
                              <option>SE</option>
                              <option>SP</option>
                              <option>TO</option>
                            </select>
                          </div>
                          <div class="form-group col-md-2">
                            <label for="cep">CEP</label>
                            <input type="text" name="cep" class="form-control" id="cep">
                          </div>
                          <div class="form-group col-md-3">
                            <label for="email">E-mail:</label>
                            <input type="text" name="email" class="form-control" id="email" required>
                          </div>
                          <div class="form-group col-md-2">
                            <label for="telefone">Telefone:</label>
                            <input type="text" name="fone" class="form-control" id="telefone"  required>
                          </div>
                        </div>
                        <div class="form-group">                          
                          <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" name="atesto" value="Atesto que todas as informação constantes neste formulário são minhas e de minha inteira responsabilidade quanto à comprovação das mesmas." id="atesto" required>
                            <label class="custom-control-label" for="atesto">Atesto que todas as informação constantes neste formulário são minhas e de minha inteira responsabilidade quanto à comprovação das mesmas.</label>
                          </div>
                        </div>                        
                        <div class="form-group text-center">
                          <button type="submit" class="btn btn-outline-primary btn-lg">Enviar Cadastro <i class="fas fa-paper-plane"></i></button>
                          <a href="documentos.html">Página de Uploads</a>
                        </div>                        
                    </form>
                    
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
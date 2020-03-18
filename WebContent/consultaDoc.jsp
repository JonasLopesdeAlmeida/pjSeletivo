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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
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

<!-- dataTables JS -->
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript"
	src="rs/DataTables/js/jquery.dataTables.js"></script>



<title>PROCESSO SELETIVO - SEMED</title>

<script>
	$(document).ready(function() {
		$('#example').DataTable({
			"language" : {
				"lengthMenu" : "Display _MENU_ records per page",
				"zeroRecords" : "Nothing found - sorry",
				"info" : "Showing page _PAGE_ of _PAGES_",
				"infoEmpty" : "No records available",
				"infoFiltered" : "(filtered from _MAX_ total records)"
			}
		});
	});
</script>



</head>





<body class="bg-light">
	<section id="header">
	<div class="container py-2 bg-white">
		<div class="row text-center">
			<div class="col-12 px-2">
				<img class="img-responsive" src="imgs/logo3.png">
			</div>

		</div>
	</div>
	</section>
	<section id="cadastro">
	<div class="container py-3 bg-white">

		<%
			int id_cargo = Integer.parseInt(request.getParameter("id_cargo"));

			if (id_cargo != 0) {

				PreparedStatement ps = null;
				Connection con = null;
				ResultSet rs = null;
				SimpleDateFormat dateFormat = null;
				{

					try {
						Class.forName("org.postgresql.Driver").newInstance();
						con = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo", "postgres",
								"252107");
						ps = con.prepareStatement(
								"select cargo.id_cargo as id_cargo,cargo.descricao as cargo,candidato.nomecandidato as cand,candidato.cpf as cpf,"
										+ "documento.descricao_doc as documento,file,upload.pontuacao as ponto,candidato.dataregistro as data from upload "
										+ "inner join cargo on cargo.id_cargo=upload.id_cargo "
										+ "inner join candidato on candidato.id_candidato=upload.id_candidato "
										+ "inner join documento on documento.id_doc=upload.id_doc "
										+ "where cargo.id_cargo=? ");
						ps.setInt(1, id_cargo);
						rs = ps.executeQuery();
						if (rs.next()) {
		%>

		<h1>
			<center><%=rs.getString("cargo")%></center>
		</h1>

		<br>

		<%
			} else

						{
							response.sendRedirect("erroPage.jsp");
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
			}
		%>

		<table class="table table-bordered">
			<thead class="bg-light">
				<th>Cargo</th>
				<th>Candidato</th>
				<th>CPF</th>
				<th>Documento</th>
				<th>Pontucao</th>
				<th>Arquivo</th>

			</thead>


			<%
				int id_cargo2 = Integer.parseInt(request.getParameter("id_cargo"));

				int limite = 20;
				String numPagina = request.getParameter("numpagina");
				if (numPagina == null)
					numPagina = "1";
				int offset = (Integer.parseInt(numPagina) * limite) - limite;

				if (id_cargo2 != 0) {

					PreparedStatement ps = null;
					Connection con = null;
					ResultSet rs = null;
					SimpleDateFormat dateFormat = null;
					{

						try {
							Class.forName("org.postgresql.Driver").newInstance();
							con = DriverManager.getConnection("jdbc:postgresql://localhost/bdseletivo", "postgres",
									"252107");
							ps = con.prepareStatement(
									"select id_upload, cargo.id_cargo as id_cargo,cargo.descricao as cargo,candidato.nomecandidato as cand,candidato.cpf as cpf,"
											+ "documento.descricao_doc as documento,file,upload.pontuacao as ponto,candidato.dataregistro as data from upload "
											+ "inner join cargo on cargo.id_cargo=upload.id_cargo "
											+ "inner join candidato on candidato.id_candidato=upload.id_candidato "
											+ "inner join documento on documento.id_doc=upload.id_doc "
											+ "where cargo.id_cargo=? " + " order by nomecandidato limit 20 offset "
											+ offset);
							ps.setInt(1, id_cargo2);
							rs = ps.executeQuery();
							while (rs.next()) {
			%>
			<tbody>
				<tr>

					<td><%=rs.getString("cargo")%></td>
					<td><%=rs.getString("cand")%></td>
					<td><%=rs.getString("cpf")%></td>
					<td><%=rs.getString("documento")%></td>
					<td><%=rs.getString("ponto")%></td>
					<td><a href="//<%=rs.getString("file")%>" target="_blank">Clique
							aqui</a></td><!-- NAVEGADOR BLOQUEANDO CAMINHO DO ARQUIVO -->

					<%
						}
					%>


				</tr>
			</tbody>
		</table>

		<%
			//SELECT FAZENDO A CONTAGEM DE REGISTROS POR CARGO

						ps = con.prepareStatement(
								"select cargo.id_cargo as id_cargo, count(*) AS contaRegistros from upload inner join cargo on cargo.id_cargo=upload.id_cargo where cargo.id_cargo=? GROUP BY cargo.id_cargo ");
						ps.setInt(1, id_cargo2);
						rs = ps.executeQuery();
						rs.next();

						int totalRegistros = Integer.parseInt(rs.getString("contaRegistros"));
						int totalPaginas = totalRegistros / limite;
						if (totalRegistros % limite != 0)
							totalPaginas++;
						//out.println("Quantidade de registros: " + totalRegistros);
						//out.println("Quantidade de paginas: " + totalPaginas);
		%>


		<nav aria-label="Navegação de página exemplo">
		<ul class="pagination justify-content-center">

			<%
				int pagAnterior;
							if (Integer.parseInt(numPagina) > 1) {

								pagAnterior = Integer.parseInt(numPagina) - 1;

								out.println(
										"<li class= page-item disabled> <a class=page-link  href= consultaDoc.jsp?numpagina="
												+ pagAnterior + "&id_cargo=" + id_cargo2 + "> Anterior</a></li>");
							}
			%>

			<%
				//interação para delimitar quantidade de link de paginas na tela.
							int i = (Integer.parseInt(numPagina) - 3);

							for (limite = i + 4; i <= limite; i++) {

								if (i < 1) {
									i = 1;
									limite = 4;
								}
								if (limite > totalPaginas) {
									limite = totalPaginas;
									i = limite - 4;
								}
								if (i < 1) {
									i = 1;
									limite = totalPaginas;
								}

								if (i == Integer.parseInt(numPagina))
									out.println(
											"<b><li class= page-item ><a class=page-link href= consultaDoc.jsp?id_cargo="
													+ id_cargo2 + "&numpagina=" + i + ">" + i + "</a></li></b>");
								else
									out.println("<li class= page-item ><a class=page-link  href= consultaDoc.jsp?id_cargo="
											+ id_cargo2 + "&numpagina=" + i + ">" + i + "</a></li>");
							}
			%>

			<%
				int pagProxima;
							//if ((totalRegistros - (Integer.parseInt(numPagina) * limite)) > 0) {

							pagProxima = Integer.parseInt(numPagina) + 1;

							out.println("<li class= page-item > <a class=page-link  href= consultaDoc.jsp?numpagina="
									+ pagProxima + "&id_cargo=" + id_cargo2 + "> Próximo </a></li>");
							//}
			%>

		</ul>
		</nav>


	</div>



	</section>


	<%
		} catch (ClassNotFoundException erroClass) /*erro caso ele não localize a classe o driver*/
				{
					out.println("Classe Driver JDBC não foi localizado, erro " + erroClass);
				}

				catch (SQLException erroSQL) /* erro no banco de dados */
				{
					out.println("Erro de conexão com o banco de dados , erro" + erroSQL);
				}

				finally {
					if (rs != null)
						rs.close();
					if (ps != null)
						ps.close();
					if (con != null)
						con.close();
				}
			}

		}
	%>

</body>
</html>
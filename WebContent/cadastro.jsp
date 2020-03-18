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

<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery.maskedinput/1.4.1/jquery.maskedinput.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<title>PROCESSO SELETIVO - SEMED</title>

</head>

<script type="text/javascript">
	function verifica(value) {
		var input = document.getElementById("input");
		if (value == 2) {
			input.disabled = false;
		} else if (value == 3) {
			input.disabled = true;
		}
	};
</script>



<body class="bg-light">
	<section id="header">
	<div class="container py-2 bg-white">
		<div class="row text-center">
			<div class="col-12 px-2">
				<img class="img-responsive" src="imgs/logo3.png">
			</div>
			<div class="col-12">
				<h3>SECRETARIA MUNICIPAL DE EDUCAÇÃO</h3>
				<h4 class="text-light bg-primary">FORMULÁRIO DE INSCRIÇÃO
					ON-LINE</h4>
			</div>
		</div>
	</div>
	</section>
	<section id="cadastro">
	<div class="container py-3 bg-white">

		<%
			Date dataAtual = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
			String dataStr = sdf.format(dataAtual);
		%>
		<div class="row">
			<div class="col-12">
				<form action="ServerCandidato" method="post">
					<div class="row">

						<input type="hidden" class="form-control text-primary"
							id="id_cargo" name="dataregistro" value="<%=dataStr%>">
						<%
							int id_cargo = Integer.parseInt(request.getParameter("id_cargo"));

							String nome = "SEMED20200";
							int num = 11;

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
										ps = con.prepareStatement("select * from cargo where id_cargo=?");
										ps.setInt(1, id_cargo);
										rs = ps.executeQuery();
										ps.clearParameters();
										if (rs.next()) {
						%>


						<div class="form-group col-md-12">
							<label for="nInscricao" class="text-primary">CARGO:</label> <input
								type="hidden" class="form-control text-primary" id="id_cargo"
								name="id_cargo" value="<%=rs.getInt("id_cargo")%>"> <input
								type="text" class="form-control text-primary" id="descricao"
								name="descricao" value="<%=rs.getString("descricao")%>"
								disabled>

						</div>



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
							}
						%>

					</div>
					<div class="form-row">

						<div class="form-group col-md-12">
							<label for="nomeCandidato">NOME DO CANDIDATO:</label> <input
								type="hidden" class="form-control" id="nomeCandidato"
								name="numinscricao" value="<%=nome%>" required> <input
								type="text" class="form-control" id="nomeCandidato"
								name="nomecandidato" style="text-transform: uppercase;" required>
						</div>
					</div>

					<div class="form-row">
						<div class="form-group col-md-2">
							<label for="Gernero">GÊNERO:</label> <select id="Gernero"
								name="genero" class="form-control" required>
								<option selected></option>
								<option>Masculino</option>
								<option>Feminino</option>
								<option>Outro</option>
							</select>
						</div>

						<div class="form-group col-md-2">
							<label for="Nacionalidade">NACIONALIDADE:</label> <select
								id="Nacionalidade" name="nacionalidade" class="form-control"
								required>
								<option selected></option>
								<option>Brasileira</option>
								<option>Estrangeira</option>
							</select>


						</div>
						<div class="form-group col-md-3">
							<label for="EstadoCivil">ESTADO CIVIL:</label> <select
								id="EstadoCivil" name="estadocivil" class="form-control"
								required>
								<option selected></option>
								<option>Solteiro(a)</option>
								<option>Casado(a)</option>
								<option>Divorciado(a)</option>
								<option>Viúvo(a)</option>
								<option>Separado(a)</option>
								<option>União Estável</option>
							</select>
						</div>
						<div class="form-group col-md-3">
							<label for="DataNascimento">DT/NASCIMENTO:</label> <input
								type="text" name="datanasc" class="form-control" id="data"
								required>
						</div>
						<div class="form-group col-md-2">
							<label for="idade">IDADE:</label> <input type="number"
								name="idade" class="form-control" id="idade" required>
						</div>
					</div>

					<div class="form-row">
						<div class="form-group col-md-3">
							<label for="rgNumero">RG nº:</label> <input type="text"
								class="form-control" name="rgnumero" id="rgNumero" required>
						</div>
						<div class="form-group col-md-5">
							<label for="rgOrgao">RG Órgão Expedidor:</label> <input
								type="text" name="rgOrgao" class="form-control" id="rgOrgao"
								style="text-transform: uppercase;" required>
						</div>
						<div class="form-group col-md-1">
							<label for="rgUf">UF:</label> <select id="rgUf" name="rguf"
								class="form-control" required>
								<option selected></option>
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
							<label for="rgData">RG Data Expedição:</label> <input type="text"
								name="rgdata" class="form-control" id="data1" required>
						</div>
					</div>

					<div class="form-row">
						<div class="form-group col-md-3">
							<label for="cpf">Nº CPF:</label> <input type="text" name="cpf"
								class="form-control" id="cpf" required>
						</div>
						<div class="form-group col-md-2">
							<label for="cnh">Nº CNH:</label> <input type="text" name="cnh"
								class="form-control" id="cnh">
						</div>
						<div class="form-group col-md-1">
							<label for="cnh">Categoria:</label> <input type="text"
								name="categoria" class="form-control"
								style="text-transform: uppercase;" id="cnh">
						</div>

						<div class="form-group col-md-3">
							<label for="def1">Pessoa Com Deficência:</label> <select
								id="def1" name="deficiencia" class="form-control"
								onchange="verifica(this.value)">
								<option value="1" selected></option>
								<option value="2">2 - Sim</option>
								<option value="3">3 - Não</option>
							</select>
						</div>
						<div class="form-group col-md-3">
							<label for="defQual">Tipo Deficência?</label> <select
								name="tipodef" class="form-control">
								<option selected></option>
								<option>Auditiva</option>
								<option>Fisíca</option>
								<option>Mental</option>
								<option>Multipla</option>
								<option>Visual</option>
							</select>
						</div>
						<div class="form-group col-md-12">
							<label for="defQual">Qual deficiência?</label> <input type="text"
								name="defqual" class="form-control">
						</div>



					</div>

					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="logradouro">ENDEREÇO: Logradouro: </label> <input
								type="text" name="endereco" class="form-control" id="logradouro"
								required>
						</div>
						<div class="form-group col-md-1">
							<label for="endNumero">Número: </label> <input type="text"
								name="numero" class="form-control" id="endNumero">
						</div>
						<div class="form-group col-md-5">
							<label for="bairo">Bairro: </label> <input type="text"
								name="bairro" class="form-control" id="bairro" required>
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-8">
							<label for="cidade">Cidade</label> <input type="text"
								name="cidade" class="form-control" id="cidade" required>
						</div>
						<div class="form-group col-md-2">
							<label for="endUf">UF:</label> <select id="endUf" name="uf"
								class="form-control" required>
								<option selected></option>
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
							<label for="cep">CEP</label> <input type="text" name="cep"
								class="form-control" id="cep">
						</div>
						<div class="form-group col-md-10">
							<label for="email">E-mail:</label> <input type="text"
								name="email" class="form-control" id="email" required>
						</div>
						<div class="form-group col-md-2">
							<label for="telefone">Telefone:</label> <input type="text"
								name="fone" class="form-control" id="fone" required>
						</div>
					</div>
					<div class="form-group">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" name="atesto"
								<%if (request.getAttribute("atesto") != null) {
				Candidato candidato = (Candidato) request.getAttribute("atesto");
				if (candidato.constroiAtesto(
						"Atesto que todas as informação constantes neste formulário são minhas e de minha inteira responsabilidade quanto à comprovação das mesmas.")) {
					out.print("checked=\"checked\"");
					out.print(" ");
				}
			}%>
								value="Atesto que todas as informação constantes neste formulário são minhas e de minha inteira responsabilidade quanto à comprovação das mesmas."
								id="atesto" required> <label
								class="custom-control-label" for="atesto">Atesto que
								todas as informação constantes neste formulário são minhas e de
								minha inteira responsabilidade quanto à comprovação das mesmas.</label>
						</div>
					</div>
					<div class="form-group text-center">
						<button type="submit" class="btn btn-outline-primary btn-lg">
							Enviar Cadastro <i class="fas fa-paper-plane"></i>
						</button>
					</div>
				</form>

			</div>
		</div>
	</div>
	</section>
	<script type="text/javascript">
		$('#fone').mask('(99)99999-9999');
		$('#cpf').mask('999.999.999-99');
		$('#data1').mask('99/99/9999');
		$('#data').mask('99/99/9999');
		$('#cep').mask('99.999-999');
	</script>

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
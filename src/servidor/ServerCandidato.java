package servidor;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dados.Candidato;
import dao.Candidatodao;

/**
 * Servlet implementation class ServerCandidato
 */
public class ServerCandidato extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerCandidato() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
  	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
  	 */
  	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		// TODO Auto-generated method stub
  		response.getWriter().append("Served at: ").append(request.getContextPath());
  		try {
  			doService(response,request);
  		
  	} catch (ClassNotFoundException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} catch (java.text.ParseException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} catch (Exception e) {
  		// TODO Auto-generated catch block
  		e.printStackTrace();
  	}
  	}

  	
  	/**
  	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
  	 */
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  		// TODO Auto-generated method stub
  	
  		try {
  			doService(response,request);
  		} catch (ClassNotFoundException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} catch (java.text.ParseException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} catch (Exception e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
  	}
  	
  	private void doService(HttpServletResponse response, HttpServletRequest request)throws Exception {
  		// TODO Auto-generated method stub
  		response.setContentType("text/html");
//  		Candidato c = (Candidato)request.getAttribute("c");
//  		Candidatodao cd = new Candidatodao();
  	//		int id_candidato = c.getId_candidato(); //Aqui você ja tem o id do usuário
  		//int     id_candidato 	   = Integer.parseInt(request.getParameter("id_candidato"));
     //  System.out.println(id_candidato);
  		
  		int     id_candidato 	   =  0;//Integer.parseInt(request.getParameter("id_candidato"));
  		int     id_cargo 	   = Integer.parseInt(request.getParameter("id_cargo"));
  		System.out.println(id_cargo);
  		String  numinscricao   = request.getParameter("numinscricao");	
  		System.out.println(numinscricao);
  		String  nomecandidato  = request.getParameter("nomecandidato");	
  		String  genero         =  request.getParameter("genero");
  		String  nacionalidade  = request.getParameter("nacionalidade");	
  		String  estadocivil    = request.getParameter("estadocivil");	
  		String  datanasc 	   = request.getParameter("datanasc");	
  		String  idade 		   = request.getParameter("idade");	
  		String	rgnumero	   = request.getParameter("rgnumero");	
  		String	rgorgao		   = request.getParameter("rgOrgao");	
  		String	rguf 		   = request.getParameter("rgUf");	
  		String	rgdata 		   = request.getParameter("rgData");	
  		String	cpf 		   = request.getParameter("cpf");	
  		String	cnh 		   = request.getParameter("cnh");	
  		String deficiencia     = request.getParameter("deficiencia");	
  		String	defqual 	   = request.getParameter("defqual");	
  		String  endereco 	   = request.getParameter("endereco");	
  		String  numero 		   = request.getParameter("numero");	
  		String  bairro 		   = request.getParameter("bairro");	
  		String	uf			   = request.getParameter("uf");	
  		String  cidade 		   = request.getParameter("cidade");	
  		String  cep 		   = request.getParameter("cep");	
  		String  email 		   = request.getParameter("email");	
  		String  fone  		   = request.getParameter("fone");	
  		String[] atesto   	   = request.getParameterValues("atesto");	
  		String  dataregistro 		   = request.getParameter("dataregistro");	
  		String  categoria  		   = request.getParameter("categoria");
  
  		Candidato c = new Candidato();
  		Candidatodao cd = new Candidatodao();
  		
  		
  		//c.setId_candidato(id_candidato);
  		c.setId_cargo(id_cargo);
  		
  		c.setNuminscricao(numinscricao); 		
  		c.setNomecandidato(nomecandidato); 	
		c.setGenero(genero);
		c.setNacionalidade(nacionalidade);
  		c.setEstadocivil(estadocivil); 		
  		c.setDatanasc(datanasc); 			
  		c.setIdade(idade); 	
  		c.setRgnumero(rgnumero);
  		c.setRgorgao(rgorgao);				
  		c.setRgdata(rgdata); 				
  		c.setRguf(rguf); 				
  		c.setCpf(cpf); 				
  		c.setCnh(cnh); 				
		c.setDeficiencia(deficiencia); 
  		c.setDefqual(defqual); 			
  		c.setEndereco(endereco); 			
  		c.setNumero(numero); 				
  		c.setBairro(bairro); 				
  		c.setUf(uf);					
  		c.setCidade(cidade); 				
  		c.setCep(cep); 				
  		c.setEmail(email); 				
  		c.setFone(fone);  
  		c.setDataregistro(dataregistro);
  		c.setCategoria(categoria);
  		 
  		if(atesto != null){
  			String dise = Arrays.toString(atesto).replaceAll("\\[","").replaceAll("\\]","");
  			
  			c.setAtesto(dise);
  			}
  		
  		cd.open();
  		if(cd != null)
  		{
  			id_candidato = cd.gravar(c);
  			
  		
  		}
        
//  		ResultSet  rs = null;
//  		PreparedStatement ps = null;
//
//  		 rs = ps.getGeneratedKeys();
//  		if (rs.next()) {
//  		    int lastId = rs.getInt(id_candidato);
//  		}
  		
  		//response.sendRedirect("sucesso.jsp");
  		//response.sendRedirect("sucesso.jsp?id_candidato="+id_candidato);
  		response.sendRedirect("upload.jsp?id_candidato=" + id_candidato);
  		
  	}


}

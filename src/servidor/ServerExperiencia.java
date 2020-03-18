package servidor;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dados.Experiencia;
import dao.Experienciadao;

/**
 * Servlet implementation class ServerExperiencia
 */
public class ServerExperiencia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerExperiencia() {
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
   	
   		int  id_candidato 	   =Integer.parseInt(request.getParameter("id_candidato"));			
   		String  local   	= request.getParameter("local");		
   		String  cargo  = request.getParameter("cargo");	
   		String	tempo 	       = request.getParameter("tempo");
   		
   		Experiencia e = new Experiencia();
   		Experienciadao ed = new Experienciadao();
   		e.setId_candidato(id_candidato);
   		e.setLocal(local); 		
   		e.setCargo(cargo); 	
   		e.setTempo(tempo); 		
   		
   		ed.open();
   		if(ed != null)
   		{
   			ed.gravar(e);
   			
   		
   		}

   	
   		
   	}
}

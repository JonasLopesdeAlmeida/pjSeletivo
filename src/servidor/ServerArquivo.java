package servidor;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 * Servlet implementation class ServerArquivo
 */
public class ServerArquivo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerArquivo() {
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
   			gerarRelatorio(response,request);
   		
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
   			gerarRelatorio(response,request);
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

private void gerarRelatorio(HttpServletResponse response, HttpServletRequest request)throws Exception
	{
		// TODO Auto-generated method stub
		
		String erro = "";
		String file = request.getParameter("file");
		String arquivo = "C:/";
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("file", file);
		byte[] bytes= null;
		ServletContext contexto = getServletContext();
		
		
		  
		Connection conn = null;


	
		try
		{
			JasperReport certificadocefe = (JasperReport)JRLoader.loadObjectFromFile(contexto.getRealPath(arquivo));
		    bytes = JasperRunManager.runReportToPdf(certificadocefe, param, conn); 
		    System.out.println("Param:" + param); 
		    System.out.println("Relatorio: " + certificadocefe);
		    System.out.println("Bytes: " + bytes); 
		    System.out.println("Jasper: " + arquivo); 

	    
		}catch (JRException e) 
		{
			erro = e.getMessage();
			System.out.println("erro "+e);
		
			
		}
		finally
		{

			if(bytes != null) {
				response.setContentType("Application/pdf");
				response.setContentLength(bytes.length);
      			ServletOutputStream sos = response.getOutputStream();
				sos.write(bytes);
				sos.flush();
				sos.close();
			}else
			{
				RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
				request.setAttribute("erro",erro);
				rd.forward(request, response);
			}
		}

}

}

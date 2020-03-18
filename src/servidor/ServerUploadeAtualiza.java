package servidor;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dados.Uploade;
import dao.Uploadedao;
import util.PontuacaoIdUploadUtil;

/**
 * Servlet implementation class ServerUploadeAtualiza
 */
public class ServerUploadeAtualiza extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerUploadeAtualiza() {
        super();
        // TODO Auto-generated constructor stub
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
   		
   		//String id_up1 = request.getParameter("id_upload_1");
   		//String pont1 = request.getParameter("pontuacao_1");
   		
   		int id_candidato = Integer.parseInt(request.getParameter("id_candidato"));   		
   		
   		int i = 3; //Integer.parseInt(request.getParameter("i"));
   		
   		List<PontuacaoIdUploadUtil> listaPontIdUpload = new ArrayList<>();
   		
   		for(int j = 0; j <= i; j++) {

   		PontuacaoIdUploadUtil pontuacao = new PontuacaoIdUploadUtil();
   		
   		try {
   		pontuacao.setIdUpload(Integer.parseInt(request.getParameter("id_upload_" + j)));
   		pontuacao.setPontuacao(Integer.parseInt(request.getParameter("pontuacao_" + j)));
   		
   		System.out.println(pontuacao.getIdUpload()+ " - " + pontuacao.getPontuacao());
  
   		
   		listaPontIdUpload.add(pontuacao);
   		} catch (Exception e) {
   			
   		}
   		
   		}  	
   		
   		
   		
   		
   		

//		
   		Uploade u = new Uploade();
   		
   		for (PontuacaoIdUploadUtil pontuacao : listaPontIdUpload) {
		Uploadedao ud = new Uploadedao();
		u.setId_upload(pontuacao.getIdUpload());
		u.setPontuacao(pontuacao.getPontuacao());
   	
   		ud.open();
   		if(ud != null)
   		{
   			ud.atualizar(u);
   			//response.sendRedirect("sucessosocioAtualiza.jsp?nome=" + nome);
   		
   		
   		}
   		}
   		response.sendRedirect("sucesso.jsp?id_candidato=" + id_candidato);
   		
   	}
}

package servidor;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import dados.Uploade;
import dao.Uploadedao;
import util.Upload_1;

/**
 * Servlet implementation class ServerUpload
 */
public class ServerUploade_1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY = "c:/uploads";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerUploade_1() {
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
   	
   		Upload_1 up = new Upload_1();
        up.setFolderUpload(UPLOAD_DIRECTORY);
        if(up.formProcess(getServletContext(), request))
        {			
 
        int  id_cargo   =Integer.parseInt(up.getForm().get("id_cargo").toString());

   		int  id_candidato   =Integer.parseInt(up.getForm().get("id_candidato").toString());	
   		
   		Map<String, String> map = up.getForm();
   		
	   	 for (String name : map.keySet())  
	         System.out.println("key: " + name); 
	       
	     // using values() for iteration over keys 
	     for (String url : map.values())  
	         System.out.println("value: " + url); 
	     
	     Set<String> set = map.keySet()
	             .stream()
	             .filter(s -> s.startsWith("id_doc"))
	             .collect(Collectors.toSet());
	     
	     List<String> mainList = new ArrayList<String>();
	     mainList.addAll(set);
	     
	     Collections.sort(mainList);
	     
	     System.out.println("set: " + mainList.get(0).split("id_doc")[1]); 

   		
   		int pontuacao = 0;
   		String dataregistro = request.getParameter("dataregistro");
   		
   		if(ServletFileUpload.isMultipartContent(request)){
   			try {
   			List<FileItem> multiparts = new ServletFileUpload(
   			new DiskFileItemFactory()).parseRequest((RequestContext) request);

   			for(FileItem item : multiparts){
   			if(!item.isFormField()){
   			String name = new File(item.getName()).getName();
   			item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
   			}
   			}
   			}
   			catch (Exception ex) {
   				request.setAttribute("message", "File Upload Failed due to " + ex);
   			
   			}
   			}
   		
   		
   		List<String> arquivos = up.getFiles();
   		
   		int _i = 0;
   		for (String file : arquivos) {
   			
   			System.out.println("Arquivo: " + mainList);
   			
   			file = UPLOAD_DIRECTORY + "/" + up.getFiles().get(_i).toString();
   			//id_doc   =Integer.parseInt(up.getForm().get("id_doc"+ _i).toString());	
   			Uploade u = new Uploade();
   	   		Uploadedao ud = new Uploadedao();
   	   		u.setId_cargo(id_cargo);
   	   		u.setId_candidato(id_candidato); 		
   	   		u.setId_doc(Integer.parseInt(mainList.get(_i).split("id_doc")[1].toString())); 
   	   		/// e aqui também
   	   		u.setFile(file); 
   	   		u.setPontuacao(pontuacao);
   	   		u.setDataregistro(dataregistro); 
   	  
   	   		ud.open();
   	   		
   	   		if(ud != null)
   	   		{
   	   			ud.gravar(u);
   	   		}
   	   		
   	   		_i++;
			
		}
   	
   		
   		response.sendRedirect("experiencia.jsp?id_candidato=" + id_candidato);
   			//response.sendRedirect("sucesso.jsp");
        }
        	else
        {
        		System.out.print("erro");
        }
    

   	
   		
   	}

}

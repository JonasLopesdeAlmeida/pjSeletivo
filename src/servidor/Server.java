package servidor;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dados.Uploade;
import dao.Uploadedao;
import util.Upload;

/**
 * Servlet implementation class Server
 */
public class Server extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String UPLOAD_DIRECTORY = "c:/uploads";
       
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
 
   		Upload up = new Upload();
        up.setFolderUpload(UPLOAD_DIRECTORY);
        if(up.formProcess(getServletContext(), request))
        {	
      
        	String   dataregistro = request.getParameter("dataregistro");
        	int  id_cargo   =Integer.parseInt(up.getForm().get("id_cargo").toString());
        	int  id_candidato   =Integer.parseInt(up.getForm().get("id_candidato").toString());	
        	int id_doc  =Integer.parseInt(up.getForm().get("id_doc").toString());
        	String file    = UPLOAD_DIRECTORY + "/" + up.getFiles().get(0).toString();      
    		int pontuacao  =0;// Integer.parseInt(up.getForm().get("pontuacao").toString());      
    	
       		
    		Uploade u = new Uploade();
   	   		Uploadedao ud = new Uploadedao();
       	   		
       	   	u.setFile(file); 
       	   	u.setDataregistro(dataregistro);
       	   	u.setId_cargo(id_cargo);
       	   	u.setId_candidato(id_candidato);
       	   	u.setId_doc(id_doc);
    	   u.setPontuacao(pontuacao);
       		

       		ud.open();
       		
       		if(ud != null)
       		{
       			ud.gravar(u);
       		}
       		
       		response.sendRedirect("upload.jsp?id_candidato=" + id_candidato);
       }
       else
       {
       	System.out.print("erro");
       }
        
		
   		
   		/*
   		System.out.println("Teste1: " + ServletFileUpload.isMultipartContent(request));
   		
   		if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(
                                         new DiskFileItemFactory()).parseRequest(request);
                
                System.out.println("Lista:" + multiparts);
               
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        String name = new File(item.getName()).getName();
                        System.out.println("name:" + name);
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                    }
                }
            
               //File uploaded successfully
               request.setAttribute("message", "File Uploaded Successfully");
            } catch (Exception ex) {
               request.setAttribute("message", "File Upload Failed due to " + ex);
            }          
          
        }else{
            request.setAttribute("message",
                                 "Sorry this Servlet only handles file upload request");
        }
   		*/
   		

   		
   		
   		}

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author marcelosiedler
 */
public class Upload {
   private String folderUpload;
   private List<String> files;
 
   Map<String,String> form ;


    public List<String> getFiles() {
        return files;
    }
   
    public Map getForm() {
        return form;
    }
    
   
   public Upload()
   {
       this.folderUpload = "upload";
       files = new ArrayList<String>();
   }

    public String getFolderUpload() {
        return folderUpload;
    }

    public void setFolderUpload(String folderUpload) {
        this.folderUpload = folderUpload;
    }
   
    public boolean formProcess(ServletContext sc, HttpServletRequest request) {
        this.form = new HashMap<String,String>();
        Map<String, String> itemForm;
        
        File file;
        int maxFileSize = 500000 * 1024;
        int maxMemSize =  500000 * 1024;
        //String filePath = sc.getRealPath("/WebContent/WEB-INF/"+this.folderUpload);
        String filePath = this.folderUpload;
        
        //System.out.println("A: " + sc.getRealPath("/WebContent/WEB-INF/"+this.folderUpload));
        
        boolean ret;
        String contentType = request.getContentType();
        
        //System.out.println("contentType: " + contentType);
        if ((contentType.indexOf("multipart/form-data") >= 0)) {

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);
            factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxFileSize);
            try {
                List fileItems = upload.parseRequest((RequestContext) request);
                Iterator i = fileItems.iterator();
                //int id_doc = Integer.parseInt(request.getParameter("id_doc"));
                //int id_candidato = Integer.parseInt(request.getParameter("id_candidato"));
                
                while (i.hasNext()) {
                    FileItem fi = (FileItem) i.next();
                    if (!fi.isFormField()) {
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        if (!fileName.isEmpty()) {
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            String name = "SEMED2020" + 1 + (int) (Math.random() * 100000) + new Date().getTime() + ".pdf";
                          //  int codigo = id_candidato;
                            file = new File(filePath + "/"+ name);
                            fi.write(file);
                            files.add(name);
                        }
                    }
                    else
                    {
                         
                         form.put(fi.getFieldName(), fi.getString());
                        
                    }
                }
                ret = true;
               
            } catch (Exception ex) {
                System.out.println(ex);
                ret = false;
            }
        } else {
           ret = false;
        }
        return ret;
    }
    
    
}

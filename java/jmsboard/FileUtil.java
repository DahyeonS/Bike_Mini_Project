package jmsboard;


import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	public static MultipartRequest uploadFile(HttpServletRequest request,
			String saveDirectory,int maxPostSize) {
		try {
			return new MultipartRequest(request,saveDirectory,maxPostSize,"UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void download(HttpServletRequest request,HttpServletResponse response,
			String Directory,String sfileName) {
		String saveDirectory=request.getServletContext().getRealPath(Directory);
		try{
			
			File file=new File(saveDirectory,sfileName);
			InputStream inStream=new FileInputStream(file);
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment; filename=\""+sfileName+"\"");
			response.setHeader("Content-Length", ""+file.length() );
			
			OutputStream outStream=response.getOutputStream();
			byte b[] = new byte[(int)file.length()];
			int readBuffer=0;
			while((readBuffer=inStream.read(b))>0){
				outStream.write(b,0,readBuffer);
			}
			inStream.close();
			outStream.close();
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void deleteFile(HttpServletRequest request,String Directory,String filename) {
		String saveDirectory=request.getServletContext().getRealPath(Directory);
		File file=new File(saveDirectory+File.separator+ filename);
		if(file.exists()) {
			file.delete();
		}
	}
}

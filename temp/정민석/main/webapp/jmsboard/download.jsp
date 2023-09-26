<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% try{
	String saveDirectory=application.getRealPath("/uploads");
	String saveFilename=request.getParameter("sName");
	File file=new File(saveDirectory,saveFilename);
	InputStream inStream=new FileInputStream(file);
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\""+saveFilename+"\"");
	response.setHeader("Content-Length", ""+file.length() );
	out.clear();
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
%>
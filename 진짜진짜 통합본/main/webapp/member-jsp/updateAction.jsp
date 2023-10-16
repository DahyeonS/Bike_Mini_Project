<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String role = request.getParameter("role");
%>    
<%
Connection conn = null;
PreparedStatement pstmt = null;
int rs = 0;

try {
	String driver = "com.mysql.cj.jdbc.Driver";
	Class.forName(driver);
	
	String dbname = "javaweb";	
	String url = "jdbc:mysql://localhost:3306/"+dbname+"?ServerTimezone=UTC";
	String user = "root";
	String password = "rpass";
	
	conn = DriverManager.getConnection(url, user, password);
	out.print("Conn OK!!");
	
	String sql = "update member set pw = ? , name = ?, role = ? where id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, pw);
	pstmt.setString(2, name);
	pstmt.setString(3, role);
	pstmt.setString(4, id);
	
	rs = pstmt.executeUpdate();	
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	try{		
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>    
<script>
<%if(rs == 1){
	session.setAttribute("name", name);
%>
	alert('회원정보가 수정되었습니다.');
	location.href = 'update.jsp';
<%}else{%>
	alert('죄송합니다. 잠시후에 다시 해주세요.');
	history.back();
<%}%>
</script>












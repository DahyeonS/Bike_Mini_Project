<%@page import="java.util.Date"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="loginCheck.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");
%>
<%
//db access
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
MemberDTO dto = null;
try {
	String driver = "com.mysql.cj.jdbc.Driver";
	Class.forName(driver);
	
	String dbname = "javaweb";	
	String url = "jdbc:mysql://localhost:3306/"+dbname+"?ServerTimezone=UTC";
	String user = "root";
	String password = "rpass";
	
	conn = DriverManager.getConnection(url, user, password);
	out.print("Conn OK!!");
	
	String sql = "select * from member where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();	
	if(rs.next()){
		int idx = rs.getInt("idx");
		String pw = rs.getString("pw");
		String name = rs.getString("name");
		String role = rs.getString("role");
		Date regDate = rs.getDate("regdate");
		
		dto = new MemberDTO(idx, id, pw, name, role, regDate);
	}
	
	
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원정보수정</h2>
<hr>
<%if(session.getAttribute("id") != null){ %>
<form action="updateAction.jsp" method="post">
	<table border="1">
		<tr><th>ID</th><td><%=dto.getId()%></td></tr>
		<tr><th>PW</th><td><input type="text" name="pw" value="<%=dto.getPw()%>"></td></tr>
		<tr><th>Name</th><td><input type="text" name="name" value="<%=dto.getName()%>"></td></tr>
		<tr><th>Role</th><td>
		<%if(dto.getRole().equals("1")){%>	
		<input type="radio" name="role" value="1" checked="checked">Member
		<input type="radio" name="role" value="0">Admin
		<%} %>
		<%if(dto.getRole().equals("0")) {%>
		<input type="radio" name="role" value="1">Member
		<input type="radio" name="role" value="0" checked="checked">Admin
		<%}%>
		</td></tr>
		<tr><td colspan="2"><input type="submit" value="Submit"></td></tr>
	</table>
</form>
<%} %>
</body>
</html>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%// getParameter()
%>    
<%
//db access
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

List<MemberDTO> list = new ArrayList<>();

try {
	String driver = "com.mysql.cj.jdbc.Driver";
	Class.forName(driver);
	
	String dbname = "javaweb";	
	String url = "jdbc:mysql://localhost:3306/"+dbname+"?ServerTimezone=UTC";
	String user = "root";
	String password = "rpass";
	
	conn = DriverManager.getConnection(url, user, password);
	out.print("Conn OK!!");
	
	String sql = "select idx, id, pw, name, role, regdate from member order by idx desc";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();	
	while(rs.next()){
		int idx = rs.getInt("idx");
		String id = rs.getString("id");
		String pw = rs.getString("pw");
		String name = rs.getString("name");
		String role = rs.getString("role");
		Date regDate = rs.getDate("regdate");
		
		MemberDTO dto = new MemberDTO(idx, id, pw, name, role, regDate);
		list.add(dto);
		
	}
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	try{		
		if(rs != null) rs.close();
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
<title>memberList.jsp</title>
</head>
<body>
<%@include file="submenu.jsp" %>
<h2>회원목록</h2>
<hr>
<table border="1">
<tr>
	<th>Idx</th>
	<th>ID</th>
	<th>PW</th>
	<th>Name</th>
	<th>Role</th>
	<th>Regdate</th>
</tr>

<% for (MemberDTO dto : list) { %>
	<tr>
		<td><%=dto.getIdx() %></td>
		<td><%=dto.getId() %></td>
		<td><%=dto.getPw() %></td>
		<td><%=dto.getName() %></td>
		<td><%=dto.getRole() %></td>
		<td><%=dto.getRegdate() %></td>
	</tr>
<% } %>

</table>
</body>
</html>
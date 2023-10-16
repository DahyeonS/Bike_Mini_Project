<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
response.setCharacterEncoding("utf-8");

String id = (String)session.getAttribute("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String role = request.getParameter("role");
MemberDTO dto = new MemberDTO(id, pw, name, role);

MemberDAO dao = new MemberDAO();
int rs = dao.update(dto);

if(rs == 1) {			
	session.setAttribute("name", name);
}

Map<String, String> map = new HashMap<>();
map.put("rs", rs+"");

String gson = new Gson().toJson(map);
%>
<%=gson %>		
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
String pw = request.getParameter("pw");

MemberDTO dto = new MemberDTO();
dto.setId(id);

MemberDAO dao = new MemberDAO();
dto = dao.getMember(dto);

int rs = 0;
if (dto != null) {
	if (dto.getPw().equals(pw)) {
		session.setAttribute("id", id);
		session.setAttribute("name", dto.getName());
		rs = 1;
	}
} 

Map<String, String> map = new HashMap<>();
map.put("rs", rs+"");

String gson = new Gson().toJson(map);
%>
<%=gson %>
		
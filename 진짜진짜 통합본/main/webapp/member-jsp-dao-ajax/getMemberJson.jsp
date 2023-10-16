<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");

MemberDTO dto = new MemberDTO();
dto.setId(id);

MemberDAO dao = new MemberDAO();
dto = dao.getMember(dto);

Map<String, Object> map = new HashMap<>();
if(dto == null){
	map.put("rs", "0");	
}else{
	map.put("rs", dto);	
}

String gson = new Gson().toJson(map);
System.out.println(gson);
%>
<%=gson %>
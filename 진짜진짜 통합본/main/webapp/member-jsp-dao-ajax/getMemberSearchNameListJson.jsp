<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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

String name = request.getParameter("name");

MemberDTO dto = new MemberDTO();
dto.setName(name);

MemberDAO dao = new MemberDAO();
List<MemberDTO> list = new ArrayList<>();
list = dao.getMemberSearchNameList(dto);

Map<String, Object> map = new HashMap<>();
if(list.size() == 0){
	map.put("rs", "0");	
}else{
	map.put("rs", list);	
}

String gson = new Gson().toJson(map);
System.out.println(gson);
%>
<%=gson %>
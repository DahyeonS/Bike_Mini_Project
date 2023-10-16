<%@page import="member.common.CommonUtil"%>
<%@page import="member.dto.MemberDTO"%>
<%@page import="member.dto.PagingDTO"%>
<%@page import="member.dao.MemberDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

String curPage = request.getParameter("page");
int pageNum = 1;
if(curPage != null) {
	pageNum = Integer.parseInt(curPage);			
}
int listNum = CommonUtil.listNum;
int blockNum = CommonUtil.blockNum;

// 검색을 위해 필요
Map<String,String> search = new HashMap<>();
search.put("searchSelect", "name");
search.put("searchText", "");

MemberDAO dao = new MemberDAO();
// 1. count
int totalCount = dao.getMemberCount(search);
// 2. list
List<MemberDTO> list = dao.getMemberListPaging(pageNum, listNum, search);
// 3. paging
PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
paging.setPaging();
System.out.println(paging);

Map<String, Object> map = new HashMap<>();
if(list.size() ==0) {
	map.put("rs", "0");
	map.put("paging", "0");
}else {
	map.put("rs", list);
	map.put("paging", paging);
}

String gson = new Gson().toJson(map);
%>
<%=gson %>
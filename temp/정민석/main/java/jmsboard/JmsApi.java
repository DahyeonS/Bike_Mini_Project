package jmsboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import board.BoardDAO;
import board.BoardDAOimpl;
import board.BoardDTO;
import member.MemberDTO;
import member.MemberService;
import member.MemberServiceImpl;


public class JmsApi {
	MemberService service = new MemberServiceImpl();

	
	
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/writeJson.json")) {
			HttpSession session = request.getSession();
			String id=	(String)session.getAttribute("id");
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			
			if (dto != null) {
				if (id.equals(dto.getId())) {
					jsonObject.addProperty("rs", 1);
				}
				else jsonObject.addProperty("rs", 0);
				response.getWriter().write(jsonObject.toString());
			}
		}else if(action.equals("/serch.json")) {
			BoardDAO dao = new BoardDAOimpl();
			Map<String, Object> param = new HashMap<String, Object>();
			String serchField = request.getParameter("serchField");
			String serchWord = request.getParameter("serchWord");
			if(serchWord!=null){
				param.put("serchField", serchField);
				param.put("serchWord", serchWord);
			}
			int totalCount = dao.selectCount(param);
			int pageSize=10;
			int blockPage=5;
			int totalPage=(int)Math.ceil((double)totalCount/pageSize);
			
			int pageNum=1;
			String pageTemp=request.getParameter("pageNum");
			if(pageTemp!=null && !pageTemp.equals("")){
				pageNum=Integer.parseInt(pageTemp);
			}
			int start = (pageNum -1)*pageSize +1;
			int end=pageNum*pageSize;
			param.put("start",start);
			param.put("end",end);
			List<BoardDTO> boardLists = dao.selectListPage(param);
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("boardLists", boardLists);
			map.put("totalCount", totalCount);
			map.put("pageSize", pageSize);
			map.put("pageNum", pageNum);
			map.put("totalPage", totalPage);
			map.put("blockPage", blockPage);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}else if (action.equals("/page.json")) {
			BoardDAO dao = new BoardDAOimpl();
			Map<String, Object> param = new HashMap<String, Object>();
			String pagingStr="";
			String reqUrl="board.jsp";
			String serchField = request.getParameter("serchField");
			String serchWord = request.getParameter("serchWord");
			if(serchWord!=null){
				param.put("serchField", serchField);
				param.put("serchWord", serchWord);
			}
			int totalCount = dao.selectCount(param);
			int pageSize=10;
			int blockPage=5;
			
			int pageNum=1;
			String pageNumTemp=request.getParameter("pageNum");
			System.out.println(pageNumTemp);
			if(pageNumTemp!=null && !pageNumTemp.equals("")){
				pageNum=Integer.parseInt(pageNumTemp);
			}
			int totalPages=(int)(Math.ceil((double)totalCount/pageSize));
			
			int pageTemp=(((pageNum-1)/blockPage)*blockPage)+1;
			if(pageTemp!=1) {
				pagingStr += "<a href='" + reqUrl + "?pageNum=1'>[첫 페이지]</a>";
				pagingStr+="&nbsp;";
				pagingStr+="<a href='"+reqUrl+"?pageNum="+(pageTemp-1)+"'>[이전블록]</a>";	
			}
			
			int blockCount=1;
			while(blockCount<=blockPage&&pageTemp<=totalPages) {
				if(pageTemp==pageNum) {
					pagingStr+="&nbsp;"+pageTemp+"&nbsp;";
				}else {
					pagingStr+="&nbsp;<a href = '"+reqUrl+"?pageNum="+pageTemp+"'>"+pageTemp+"</a>&nbsp;";
				}
				pageTemp++;
				blockCount++;
			}
			if(pageTemp<=totalPages) {
				pagingStr+="<a href='"+reqUrl+"?pageNum="+pageTemp+"'>[다음 블록]</a>";
				pagingStr+="&nbsp;";
				pagingStr+="<a href='"+reqUrl+"?pageNum="+totalPages+"'>[마지막 페이지]</a>";
			}
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("pagingStr", pagingStr);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}
	}
}

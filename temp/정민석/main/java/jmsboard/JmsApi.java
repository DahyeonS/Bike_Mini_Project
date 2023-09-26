package jmsboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.oreilly.servlet.MultipartRequest;

import board.BoardDAO;
import board.BoardDAOimpl;
import board.BoardDTO;
import member.MemberDTO;
import member.MemberService;
import member.MemberServiceImpl;


public class JmsApi {
	MemberService service = new MemberServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/login.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			
			if (dto != null) {
				if (pw.equals(dto.getPw())) {
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					session.setAttribute("nickname", dto.getNickname());
					session.setAttribute("grade", dto.getGrade());
					jsonObject.addProperty("rs", 1);
				}
			}
			else jsonObject.addProperty("rs", 0);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/idCheck.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			if(dto != null) jsonObject.addProperty("rs", 1);
			else jsonObject.addProperty("rs", 0);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/nicknameCheck.json")) {
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO();
			dto.setNickname(nickname);
			dto = service.getMemberNickname(dto);
			
			JsonObject jsonObject = new JsonObject();
			if(dto != null) jsonObject.addProperty("rs", 1);
			else jsonObject.addProperty("rs", 0);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/join.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO(id, pw, nickname);
			
			int rs = 0;
			rs = service.insert(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/pwShow.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("pw", dto.getPw());
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/update.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO(id, pw, nickname);
			int rs = 0;
			rs = service.update(dto);
			
			JsonObject jsonObject = new JsonObject();
			if (rs == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("nickname", dto.getNickname());
			}
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/delete.json")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			int rs = 0;
			
			if (pw.equals(dto.getPw())) {
				session.invalidate();
				rs = service.delete(dto);
			}
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/memberList.json")) {
			List<MemberDTO> list = service.getMemberList();
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/memberShow.json")) {
			String context = request.getParameter("context");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(context);
			dto.setNickname(context);
			dto = service.memberSearch(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", dto.getId());
			jsonObject.addProperty("pw", dto.getPw());
			jsonObject.addProperty("nickname", dto.getNickname());
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/updateAdmin.json")) {
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String grade = request.getParameter("grade");
			
			MemberDTO dto = new MemberDTO(id, null, nickname, grade);
			int rs = 0;
			rs = service.updateAdmin(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/deleteAdmin.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			int rs = 0;
			rs = service.delete(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/writeJson.json")) {
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
			int totalPage=(int)Math.ceil((double)totalCount/pageSize);
			
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

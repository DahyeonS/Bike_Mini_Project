package miniproject;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;


@WebServlet("*.json")
public class DispatcherJson extends HttpServlet {
	private static final long serialVersionUID = 1L;



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		process(request,response);
	}
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri=request.getRequestURI();
		String action=uri.substring(uri.lastIndexOf("/"));
		if(action.equals("/getMemberJson.json")) {
			String id = request.getParameter("id");
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			MemberDAO dao = new MemberDAO();
			dto = dao.getMember(dto);
			String rs = "0";
			if(dto != null) rs = "1";
			//response.sendRedirect("idCheck.jsp?rs=" + rs);
			Map<String, String> map=new HashMap<String, String>();
			map.put("rs", rs);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}else if(action.equals("/getDto.json")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			MemberDAO dao = new MemberDAO();
			dto = dao.getMember(dto);
			String gson = new Gson().toJson(dto);
			response.getWriter().write(gson);
		}else if(action.equals("/joinProc.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			
			
			MemberDAO dao = new MemberDAO();
			String regidate = "";
			MemberDTO dto = new MemberDTO(id, pw, name, regidate);
			Map<String, Object> map=new HashMap<String, Object>();
			int rs = dao.insert(dto);
			map.put("rs", rs);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}else if(action.equals("/serch.json")) {
			ServletContext application = getServletContext();
			BoardPage bp=new BoardPage();
			BoardDAO dao = new BoardDAO();
			Map<String, Object> param = new HashMap<String, Object>();
			String serchField = request.getParameter("serchField");
			String serchWord = request.getParameter("serchWord");
			if(serchWord!=null){
				param.put("serchField", serchField);
				param.put("serchWord", serchWord);
			}
			int totalCount = dao.selectCount(param);
			int pageSize=Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
			int blockPage=Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
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
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}
	}
}

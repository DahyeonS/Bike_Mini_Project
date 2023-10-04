package khBoard;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import control.JDBCUtil;

public class khBoardJson {
	khBoardDAO dao = new khBoardDAO();

	public void khBoardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri);
		System.out.println(action + 111);

		if (action.equals("/selectCount.json")) {
			
			khBoardDAO dao = new khBoardDAO();
			int totalCount = dao.selectCount();

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("totalCount", totalCount);
			response.getWriter().write(jsonObject.toString());	
		}
		else if (action.equals("/qSelectCount.json")) {

			khBoardDAO dao = new khBoardDAO();
			int totalCount = dao.qSelectCount();

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("totalCount", totalCount);
			response.getWriter().write(jsonObject.toString());		
			
		}
		else if(action.equals("/boardList.json")) {
			
			int posts_per_page = Integer.parseInt(request.getParameter("posts_per_page"));
			int page = Integer.parseInt(request.getParameter("page"));
			List<khBoardDTO> list = new ArrayList<khBoardDTO>();
			khBoardDAO dao = new khBoardDAO();
			System.out.println(posts_per_page);
			System.out.println(page);
			list = dao.boardList(posts_per_page, page);
			System.out.println(list);

			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}
		else if(action.equals("/qBoardList.json")) {

			List<khBoardDTO> list = new ArrayList<khBoardDTO>();
			khBoardDAO dao = new khBoardDAO();
			list = dao.qBoardList();

			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}
		else if(action.equals("/aBoardList.json")) {
			int qNum = Integer.parseInt(request.getParameter("num"));
			
			List<khBoardDTO> list = new ArrayList<khBoardDTO>();
			khBoardDAO dao = new khBoardDAO();
			list = dao.aBoardList(qNum);

			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}
		else if(action.equals("/searchList.json")) {
			System.out.println(3333);
			String searchWord = request.getParameter("searchWord");
			String searchField = request.getParameter("searchField");
			int posts_per_page = Integer.parseInt(request.getParameter("posts_per_page"));
			int page = Integer.parseInt(request.getParameter("page"));

			List<khBoardDTO> list = new ArrayList<khBoardDTO>();
			khBoardDAO dao = new khBoardDAO();
			list = dao.searchList(searchWord, searchField, posts_per_page, page);
			System.out.println(list);
			
			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}
		else if(action.equals("/qSearchList.json")) {
			String searchWord = request.getParameter("searchWord");
			String searchField = request.getParameter("searchField");

			List<khBoardDTO> list = new ArrayList<khBoardDTO>();
			khBoardDAO dao = new khBoardDAO();
			list = dao.qSearchList(searchWord, searchField);
			
			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}
		else if(action.equals("/insertWrite.json")) {

			String title = request.getParameter("title");
			String context = request.getParameter("context");
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String nickname = (String)session.getAttribute("nickname");

			khBoardDAO dao = new khBoardDAO();
			int rs = dao.insertWrite(title, context, id, nickname);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/qInsertWrite.json")) {

			String title = request.getParameter("title");
			String context = request.getParameter("context");
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String nickname = (String)session.getAttribute("nickname");
			
			khBoardDAO dao = new khBoardDAO();
			int rs = dao.qInsertWrite(title, context, id, nickname);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/aInsertWrite.json")) {

			String title = request.getParameter("title");
			String context = request.getParameter("context");
			int num = Integer.parseInt(request.getParameter("num"));
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String nickname = (String)session.getAttribute("nickname");
			
			khBoardDAO dao = new khBoardDAO();
			int rs = dao.aInsertWrite(title, context, id, nickname, num);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
	
		else if(action.equals("/getBoard.json")) {

			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			khBoardDTO dto = dao.getBoard(num);

			String gson = new Gson().toJson(dto);
			response.getWriter().write(gson);
		}
		else if(action.equals("/qGetBoard.json")) {

			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			khBoardDTO dto = dao.qGetBoard(num);

			String gson = new Gson().toJson(dto);
			response.getWriter().write(gson);
		}
		else if(action.equals("/updateBoard.json")) {

			int num = Integer.parseInt(request.getParameter("num"));
			String title = request.getParameter("title");
			String context = request.getParameter("context");

			khBoardDAO dao = new khBoardDAO();
			int rs = dao.updateBoard(num, title, context);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/qUpdateBoard.json")) {

			int num = Integer.parseInt(request.getParameter("num"));
			String title = request.getParameter("title");
			String context = request.getParameter("context");

			khBoardDAO dao = new khBoardDAO();
			int rs = dao.updateBoard(num, title, context);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/deleteBoard.json")) {
			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			int rs = dao.deleteBoard(num);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/beforeBoard.json")) {
			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			int beforeNum = dao.beforeBoard(num);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("beforeNum", beforeNum);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/qBeforeBoard.json")) {
			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			int beforeNum = dao.qBeforeBoard(num);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("beforeNum", beforeNum);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/nextBoard.json")) {
			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			int nextNum = dao.nextBoard(num);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("nextNum", nextNum);
			response.getWriter().write(jsonObject.toString());
		}
		else if(action.equals("/qNextBoard.json")) {
			int num = Integer.parseInt(request.getParameter("num"));
			khBoardDAO dao = new khBoardDAO();
			int nextNum = dao.qNextBoard(num);

			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("nextNum", nextNum);
			response.getWriter().write(jsonObject.toString());
		}





	}
}

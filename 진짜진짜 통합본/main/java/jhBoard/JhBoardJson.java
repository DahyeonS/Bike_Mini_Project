package jhBoard;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import member.MemberDAO;
import member.MemberDAOImpl;

public class JhBoardJson {

	JhBoardDAO jhDAO = new JhBoardDAO();
	MemberDAO MemberDAO = new MemberDAOImpl();
	
	
	public void boardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));	
			
			if(action.equals("/search.json")) {
				String searchWord = request.getParameter("searchWord");
				String searchField = request.getParameter("searchField");
				int listNum = Integer.parseInt(request.getParameter("listNum"));
				int pageNum = Integer.parseInt(request.getParameter("pageNum"));
							
				List<JhBoardDTO> jhBoardList = jhDAO.searchBoard(searchWord, searchField, listNum, pageNum);
						
				String gson = new Gson().toJson(jhBoardList);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);
			}	
			else if(action.equals("/QSearch.json")) {
				String searchWord = request.getParameter("searchWord");
				String searchField = request.getParameter("searchField");
				int listNum = Integer.parseInt(request.getParameter("listNum"));
				int pageNum = Integer.parseInt(request.getParameter("pageNum"));
				
							
				List<JhBoardDTO> jhBoardList = jhDAO.QsearchBoard(searchWord, searchField, listNum, pageNum);
						
				String gson = new Gson().toJson(jhBoardList);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);
			
			}	
			else if(action.equals("/selectCount.json")) {
				String searchWord = request.getParameter("searchWord");
				String searchField = request.getParameter("searchField");
				int totalCount = jhDAO.boardCount(searchWord, searchField);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("totalCount", totalCount);
				response.getWriter().write(jsonObject.toString());				
			}
			else if(action.equals("/QSelectCount.json")) {
				String searchWord = request.getParameter("searchWord");
				String searchField = request.getParameter("searchField");			
				int totalCount = jhDAO.QBoardCount(searchWord, searchField);

				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("totalCount", totalCount);
				response.getWriter().write(jsonObject.toString());		
			}
			else if(action.equals("/boardList.json")) {				
				int pageNum = Integer.parseInt(request.getParameter("pageNum"));
				int listNum = Integer.parseInt(request.getParameter("listNum"));
				
				List<JhBoardDTO> jhList = jhDAO.boardList(pageNum, listNum);
				
				String gson = new Gson().toJson(jhList);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);		
				
			}
			else if(action.equals("/QBoardList.json")) {
				int pageNum = Integer.parseInt(request.getParameter("pageNum"));
				int listNum = Integer.parseInt(request.getParameter("listNum"));
				
				System.out.println(pageNum);
				System.out.println(listNum);
								
				List<JhBoardDTO> jhList = jhDAO.QBoardList(pageNum, listNum);
				
				System.out.println(jhList);
				
				String gson = new Gson().toJson(jhList);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);
			}
			else if(action.equals("/AViewBoard.json")) {
				int qNum = Integer.parseInt(request.getParameter("num"));
				List<JhBoardDTO> jhList = jhDAO.ABoardList(qNum);
				String gson = new Gson().toJson(jhList);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);		
			}
			else if(action.equals("/insertWrite.json")) {
				HttpSession session = request.getSession();
				String id = (String)session.getAttribute("id");
				String nickname = (String)session.getAttribute("nickname");
				String title = request.getParameter("title");
				String context = request.getParameter("context");
				
				JhBoardDTO jhDTO = new JhBoardDTO(id, nickname, title, context);
				
				int rs = jhDAO.writeUpload(jhDTO);
				System.out.println(rs);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());				
			}	
			else if(action.equals("/QInsertWrite.json")) {
				HttpSession session = request.getSession();
				String id = (String)session.getAttribute("id");
				String nickname = (String)session.getAttribute("nickname");
				String title = request.getParameter("title");
				String context = request.getParameter("context");
				
				JhBoardDTO jhDTO = new JhBoardDTO(id, nickname, title, context);
				
				int rs = jhDAO.QWriteUpload(jhDTO);
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());				
			}
			else if(action.equals("/AInsertWrite.json")) {
				HttpSession session = request.getSession();
				String id = (String)session.getAttribute("id");
				String nickname = (String)session.getAttribute("nickname");
				String title = request.getParameter("title");
				String context = request.getParameter("context");
				int num = Integer.parseInt(request.getParameter("num"));
				
				JhBoardDTO jhDTO = new JhBoardDTO(id, nickname, title, context, num);
				
				int rs = jhDAO.AWriteUpload(jhDTO);
				System.out.println(rs);
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());				
			}
			else if(action.equals("/viewBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				JhBoardDTO dto = jhDAO.selectView(num);
				
				String gson = new Gson().toJson(dto);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);		
			}
			else if(action.equals("/QViewBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				JhBoardDTO dto = jhDAO.selectView(num);
				
				String gson = new Gson().toJson(dto);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);		
			}
			else if(action.equals("/QEditBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				String title = request.getParameter("title");
				String context = request.getParameter("context");
				
				int rs = jhDAO.editBoard(num, title, context);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());
			}		
			else if(action.equals("/editBoard.json")) {
				System.out.println("aaa");
				int num = Integer.parseInt(request.getParameter("num"));
				String title = request.getParameter("title");
				String context = request.getParameter("context");
				
				int rs = jhDAO.editBoard(num, title, context);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());
			}	
			else if(action.equals("/deleteBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int rs = jhDAO.deleteBoard(num);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());
			}
			else if(action.equals("/QDeleteBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int rs = jhDAO.deleteBoard(num);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());
			}
			else if(action.equals("/qGetBoard.json")) {

				int num = Integer.parseInt(request.getParameter("num"));
				JhBoardDTO dto = jhDAO.qGetBoard(num);

				String gson = new Gson().toJson(dto);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);
			}
			else if(action.equals("/beforeBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int beforeNum = jhDAO.beforeBoard(num);

				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("beforeNum", beforeNum);
				response.getWriter().write(jsonObject.toString());
			}
			else if(action.equals("/qBeforeBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int beforeNum = jhDAO.qBeforeBoard(num);

				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("beforeNum", beforeNum);
				response.getWriter().write(jsonObject.toString());
			}
			else if(action.equals("/nextBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int nextNum = jhDAO.nextBoard(num);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("nextNum", nextNum);
				response.getWriter().write(jsonObject.toString());
			}
			else if(action.equals("/qNextBoard.json")) {
				int num = Integer.parseInt(request.getParameter("num"));
				int nextNum = jhDAO.qNextBoard(num);

				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("nextNum", nextNum);
				response.getWriter().write(jsonObject.toString());
			}
			else if(action.equals("/page.json")) {				
				int blockNum = 5;
				int listNum = Integer.parseInt(request.getParameter("listNum"));				
				int pageNum = Integer.parseInt(request.getParameter("pageNum"));
				String searchWord = request.getParameter("searchWord");
				String searchField = request.getParameter("searchField");
				int totalCount = jhDAO.boardCount(searchWord, searchField);
				
				PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
				paging.setPaging();	
				
				String gson = new Gson().toJson(paging);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);
							
			}
			else if(action.equals("/Qpage.json")) {				
				int blockNum = 5;
				int listNum = Integer.parseInt(request.getParameter("listNum"));				
				int pageNum = Integer.parseInt(request.getParameter("pageNum"));
				String searchWord = request.getParameter("searchWord");
				String searchField = request.getParameter("searchField");				
				int totalCount = jhDAO.QBoardCount(searchWord, searchField);
				
				
				PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
				paging.setPaging();	
				String gson = new Gson().toJson(paging);
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write(gson);							
			}
			else if(action.equals("/visitCount.json")) {				
				int num = Integer.parseInt(request.getParameter("num"));
				int rs = jhDAO.visitCount(num);
				
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());										
			}
	}
}

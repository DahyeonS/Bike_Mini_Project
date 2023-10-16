package member.mvc;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.common.CommonUtil;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import member.dto.PagingDTO;

@WebServlet("*.do")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		action(request, response);
	}
	
	protected void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("action");
		String uri = request.getRequestURI();
		System.out.println(uri); // /myweb/memberList.do
		String action = uri.substring(uri.lastIndexOf("/"));
		
		MemberDAO dao = new MemberDAO();
		HttpSession session = request.getSession();		
		String view = "";
		
		if(action.equals("/main.do")) {
			System.out.println("/main.do");
			
			view = "main.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			
		}else if(action.equals("/memberList.do")) {
			System.out.println("/memberList.do");
			
			List<MemberDTO> list = dao.getMemberList();
			request.setAttribute("list", list);			
			view = "memberList.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			
		}else if(action.equals("/join.do")) {			
			System.out.println("/join.do");
			
			view = "join.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			
		}else if(action.equals("/joinAction.do")) {
			System.out.println("/joinAction.do");
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = dao.insert(dto);
			
			view = "login.do";			
			response.sendRedirect(view);
			
		}else if(action.equals("/login.do")) {
			System.out.println("/login.do");
			
			view = "login.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			
		}else if(action.equals("/loginAction.do")) {
			System.out.println("/loginAction.do"); 
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = dao.getMember(dto);
			
			if (dto != null) {
				if (dto.getPw().equals(pw)) {
					
					session.setAttribute("id", id);
					session.setAttribute("name", dto.getName());
					
					view = "main.do";
				} else {
					view = "login.do";
				}
			} else {
				view = "login.do";
			}
			
			response.sendRedirect(view);
			
		}else if(action.equals("/logout.do")) {
			System.out.println("/logout.do");
			
			session.invalidate();
			
			view = "main.do";
			response.sendRedirect(view);
			
		}else if(action.equals("/update.do")) {
			System.out.println("/update.do");
			
			String id = (String)session.getAttribute("id");

			MemberDTO dto = new MemberDTO();
			dto.setId(id);

			dto = dao.getMember(dto);
			
			request.setAttribute("dto", dto);
			
			view = "update.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			
		}else if(action.equals("/updateAction.do")) {
			System.out.println("/updateAction.do");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = dao.update(dto);
			
			session.setAttribute("name", name);
			
			view = "update.do";
			response.sendRedirect(view);
			
		}else if(action.equals("/delete.do")) {			
			System.out.println("/delete.do");
			
			String path = "delete.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(path);
			dispatcher.forward(request, response);
			
		}else if(action.equals("/deleteAction.do")) {			
			System.out.println("/deleteAction.do");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = dao.getMember(dto);
			
			if (dto.getPw().equals(pw)) {
				dao.delete(dto);
				session.invalidate();
				
				view = "main.do";
			} else {
				view = "delete.do";
			}
			
			response.sendRedirect(view);			
			
		}else if(action.equals("/memberPagingList.do")) {
			System.out.println("/memberPagingList.do");
			
			String page = request.getParameter("page");
			int pageNum = 1;
			if(page != null) {
				pageNum = Integer.parseInt(page);			
			}
			int listNum = CommonUtil.listNum;
			int blockNum = CommonUtil.blockNum;
			
			// 검색을 위해 필요
			Map<String,String> search = new HashMap<>();
			search.put("searchSelect", "name");
			search.put("searchText", "");
			
			int totalCount = dao.getMemberCount(search);
			
			List<MemberDTO> list = dao.getMemberListPaging(pageNum, listNum, search);
			PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
			paging.setPaging();
			//System.out.println(paging);
			request.setAttribute("list", list);			
			request.setAttribute("paging", paging);			
			view = "memberPagingList.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
			
		}
		
	}

}

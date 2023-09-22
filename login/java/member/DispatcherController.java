package mini_project;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("*.do")
public class DispatcherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
//		한글 처리
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}

	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri); // /myweb/memberList.do
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/index.do")) {
			response.sendRedirect("index.jsp");
		} else if (action.equals("/login.do")) response.sendRedirect("login.jsp");
		else if (action.equals("/logout.do")) response.sendRedirect("logout.jsp");
		else if (action.equals("/join.do")) response.sendRedirect("join.jsp");
		else if (action.equals("/joinProc.do")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			int age = Integer.parseInt(request.getParameter("age"));
			//MemberDTO dto = new MemberDTO(id, pw, name, age);
			
			//MemberDAO dao = new MemberDAO();
			//int rs = dao.insert(dto);
			
			//request.setAttribute("rs", rs);
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/joinJson.do")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("joinJson.jsp");
			dispatcher.forward(request, response);
		}
		else if (action.equals("/getMemberJson.do")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("getMemberJson.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/update.do")) response.sendRedirect("update.jsp");
		else if (action.equals("/updateProc.do")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			int age = Integer.parseInt(request.getParameter("age"));
			//MemberDTO dto = new MemberDTO(id, pw, name, age);
			
			//MemberDAO dao = new MemberDAO();
			//int rs = dao.update(dto);
			
			session.setAttribute("name", name);
			//request.setAttribute("rs", rs);
			RequestDispatcher dispatcher = request.getRequestDispatcher("update.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/updateJson.do")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("updateJson.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/delete.do")) response.sendRedirect("delete.jsp");
		else if (action.equals("/deleteProc.do")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			//MemberDAO dao = new MemberDAO();
			//dto = dao.getMember(dto);
			
			if (dto.getPw().equals(pw)) {
				//dao.delete(dto);
				session.invalidate();
				response.sendRedirect("index.jsp");
			} else response.sendRedirect("delete.jsp");
		} else if (action.equals("/deleteJson.do")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("deleteJson.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/memberListJson.do")) response.sendRedirect("memberListJson.jsp");
		else if (action.equals("/memberListData.do")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("memberListData.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/getMemberNameJson.do")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("getMemberNameJson.jsp");
			dispatcher.forward(request, response);
		} else if (action.equals("/memberListJstl.do")) {
			System.out.println(action); // /memberList.do
//			데이터 생성
			//MemberDAO dao = new MemberDAO();
			//List<MemberDTO> list = dao.getMemberList();
			
//			데이터 전송
			//request.setAttribute("list", list);
			String viewName = "memberListJstl.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(viewName);
			rd.forward(request, response);
		}
		// 영선 -- board 일반게시판
		else if (action.equals("/board.do")) response.sendRedirect("board.jsp");
	}

}

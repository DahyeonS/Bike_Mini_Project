package miniproject;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		process(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		process(request,response);
	}
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri=request.getRequestURI();
		String action=uri.substring(uri.lastIndexOf("/"));
		if(action.equals("/List.do")) {
			response.sendRedirect("List.jsp");
		}else if(action.equals("/login.do")) {
			response.sendRedirect("login.jsp");
		}else if(action.equals("/logout.do")) {
			response.sendRedirect("logout.jsp");
		}else if(action.equals("/loginProc.do")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			MemberDAO dao = new MemberDAO();
			dto = dao.getMember(dto);
			
			if (dto != null) {
				if (dto.getPass().equals(pw)) {
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					session.setAttribute("name", dto.getName());
					response.sendRedirect("List.do");
				} else response.sendRedirect("login.do");
			} else {
				response.sendRedirect("login.do");
			}
		}else if(action.equals("/join.do")) {
			response.sendRedirect("join.jsp");
		}else if(action.equals("/update.do")) {
			response.sendRedirect("update.jsp");
		}else if(action.equals("/updateProc.do")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto.setPass(pw);
			dto.setName(name);
			MemberDAO dao = new MemberDAO();
			int rs = dao.update(dto);
			
			session.setAttribute("name", name);
			request.setAttribute("rs", rs);
			RequestDispatcher dispatcher = request.getRequestDispatcher("update.jsp");
			dispatcher.forward(request, response);
		}else if(action.equals("/delete.do")) {
			response.sendRedirect("delete.jsp");
		}else if(action.equals("/deleteProc.do")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			MemberDAO dao = new MemberDAO();
			dto = dao.getMember(dto);
			
			if (dto.getPass().equals(pw)) {
				dao.delete(dto);
				session.invalidate();
				response.sendRedirect("List.jsp");
			} else response.sendRedirect("delete.jsp");
		}
	}
	

}

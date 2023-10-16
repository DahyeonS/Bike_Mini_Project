package member.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

@WebServlet("/updateAction.do")
public class UpdateAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String role = request.getParameter("role");
		MemberDTO dto = new MemberDTO(id, pw, name, role);
		
		MemberDAO dao = new MemberDAO();
		int rs = dao.update(dto);
		
		session.setAttribute("name", name);
		request.setAttribute("rs", rs);
		String folderName = "./member-servlet/";
		String jspName = "update.jsp";
		String path = folderName + jspName;
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
	}

}

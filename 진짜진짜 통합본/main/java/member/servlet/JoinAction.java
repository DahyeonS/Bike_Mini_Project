package member.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

@WebServlet("/joinAction.do")
public class JoinAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String role = request.getParameter("role");
		MemberDTO dto = new MemberDTO(id, pw, name, role);
		
		MemberDAO dao = new MemberDAO();
		int rs = dao.insert(dto);
		
		request.setAttribute("rs", rs);
		String folderName = "./member-servlet/";
		String jspName = "login.jsp";
		String path = folderName + jspName;
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);
		
	}

}

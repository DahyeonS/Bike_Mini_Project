package member.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

@WebServlet("/loginAction.do")
public class LoginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		
		MemberDAO dao = new MemberDAO();
		dto = dao.getMember(dto);
		String folderName = "./member-servlet/";
		if (dto != null) {
			if (dto.getPw().equals(pw)) {
				HttpSession session = request.getSession();
				session.setAttribute("id", id);
				session.setAttribute("name", dto.getName());
				String jspName = "main.jsp";
				String path = folderName + jspName;
				response.sendRedirect(path);
			} else {
				String jspName = "login.jsp";
				String path = folderName + jspName;
				response.sendRedirect(path);
			}
		} else {
			response.sendRedirect("login.jsp");
		}
	}

}

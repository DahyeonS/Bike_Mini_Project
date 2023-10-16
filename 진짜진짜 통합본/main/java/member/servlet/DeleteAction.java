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

@WebServlet("/deleteAction.do")
public class DeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("pw");
		
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		MemberDAO dao = new MemberDAO();
		dto = dao.getMember(dto);
		
		String folderName = "./member-servlet/";
		if (dto.getPw().equals(pw)) {
			dao.delete(dto);
			session.invalidate();
			String jspName = "main.jsp";
			String path = folderName + jspName;
			response.sendRedirect(path);
		} else {
			String jspName = "delete.jsp";
			String path = folderName + jspName;
			response.sendRedirect(path);
		}
	}

}

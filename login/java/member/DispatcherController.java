package member;

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
		request.setCharacterEncoding("UTF-8");
		String uri = request.getRequestURI();
		System.out.println(uri); // /myweb/memberList.do
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/index.do")) {
			response.sendRedirect("index.jsp");
		} else if (action.equals("/login.do")) response.sendRedirect("login.jsp");
		else if (action.equals("/logout.do")) response.sendRedirect("logout.jsp");
		else if (action.equals("/join.do")) response.sendRedirect("join.jsp");
		else if (action.equals("/update.do")) response.sendRedirect("update.jsp");
		else if (action.equals("/delete.do")) response.sendRedirect("delete.jsp");
		else if (action.equals("/memberList.do")) response.sendRedirect("memberList.jsp");
		
		else if (action.equals("/board.do")) response.sendRedirect("board.jsp");
	}

}

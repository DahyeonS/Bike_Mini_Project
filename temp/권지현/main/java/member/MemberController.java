package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberController {
	public void memberProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].lastIndexOf(".") == -1) {
			if (action.equals("/login.do")) response.sendRedirect("../member/login.jsp");
			else if (action.equals("/logout.do")) response.sendRedirect("../member/logout.jsp");
			else if (action.equals("/join.do")) response.sendRedirect("../member/join.jsp");
			else if (action.equals("/update.do")) response.sendRedirect("../member/update.jsp");
			else if (action.equals("/delete.do")) response.sendRedirect("../member/delete.jsp");
			else if (action.equals("/memberList.do")) response.sendRedirect("../member/memberList.jsp");
			else if (action.equals("/updateAdmin.do")) response.sendRedirect("../member/updateAdmin.jsp");
		} 
	}
}

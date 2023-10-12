package novel;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardController {
	public void boardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].lastIndexOf(".") == -1) {
			if (action.equals("/view.do")) response.sendRedirect("../novel/view.jsp");
			else if (action.equals("/board.do")) response.sendRedirect("../novel/board.jsp");
			else if (action.equals("/write.do")) response.sendRedirect("../novel/write.jsp");
			else if (action.equals("/updateBoard.do")) response.sendRedirect("../novel/updateBoard.jsp");
		}
	}
}

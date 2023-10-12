package novel;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NovelController {
	public void novelProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		NovelDAO dao = new NovelDAOImpl();
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].lastIndexOf(".") == -1) {
			if (action.equals("/boardView.do")) response.sendRedirect("../novel/boardView.jsp");
			else if (action.equals("/board.do")) response.sendRedirect("../novel/board.jsp");
			else if (action.equals("/write.do")) response.sendRedirect("../novel/write.jsp");
			else if (action.equals("/view.do")) {
				 RequestDispatcher view = request.getRequestDispatcher("../novel/view.jsp"); // 전달할 때도 문자열로 사용
			     view.forward(request, response);
			}
		}
	}
}

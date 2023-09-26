package qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaController {
	public void qnaProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].lastIndexOf(".") == -1) {
			if (action.equals("/qBoardList.do")) response.sendRedirect("../qna/qBoardList.jsp");
			if (action.equals("/boardView.do")) response.sendRedirect("../qna/boardView.jsp");
		}
	}
}

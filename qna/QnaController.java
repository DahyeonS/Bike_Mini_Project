package qna;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QnaController {
	public void qnaProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		QnaDAO dao = new QnaDAOImpl();
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].lastIndexOf(".") == -1) {
			if (action.equals("/qnaBoardList.do")) response.sendRedirect("../qna/boardList.jsp");
			else if (action.equals("/qnaBoardView.do")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("../qna/boardView.jsp");
				dispatcher.forward(request, response);
			} else if (action.equals("/qnaWrite.do")) {
				RequestDispatcher dispatcher = request.getRequestDispatcher("../qna/boardWrite.jsp");
				dispatcher.forward(request, response);
			}
		}
	}
}
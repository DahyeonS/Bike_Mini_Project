package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jmsboard.JmsApi;
import jmsboard.JmsController;

public class BoardController {
	public void boardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].equals("board")) {
			if (action.equals("/QBoardList.do")) response.sendRedirect("../board/QBoardList.jsp");
		} else if(uri.split("/",4)[2].equals("home")){
			if (action.equals("/board.do")) response.sendRedirect("../jmsboard/board.jsp");
		}else if(uri.split("/",4)[2].equals("jmsboard")){
			JmsApi ja=new JmsApi();
			ja.doPost(request, response);
			JmsController jc=new JmsController();
			jc.doPost(request, response);
		}
	}
}

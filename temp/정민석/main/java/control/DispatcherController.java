package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import jmsboard.JmsController;

@WebServlet("*.do")
public class DispatcherController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println("doGet");
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("doPost");
//		한글 처리
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		process(request, response);
	}

	protected void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);

		String action = uri.substring(uri.lastIndexOf("/"));
		if (uri.split("/", 4)[2].equals("board")) {
			if (action.equals("/QBoardList.do"))
				response.sendRedirect("../board/QBoardList.jsp");
		} else if (uri.split("/", 4)[2].equals("home")) {
			if (action.equals("/board.do"))
				response.sendRedirect("../jmsboard/board.jsp");
			else if (action.equals("/index.do")) {
				response.sendRedirect("./index.jsp");
			}
		} else if (uri.split("/", 4)[2].equals("jmsboard")) {
			JmsController jc = new JmsController();
			jc.process(request, response);
		}
		if (action.equals("/index.do"))
			response.sendRedirect("../home/index.jsp");
		else if (action.equals("/login.do"))
			response.sendRedirect("../member/login.jsp");
		else if (action.equals("/logout.do"))
			response.sendRedirect("../member/logout.jsp");
		else if (action.equals("/join.do"))
			response.sendRedirect("../member/join.jsp");
		else if (action.equals("/update.do"))
			response.sendRedirect("../member/update.jsp");
		else if (action.equals("/delete.do"))
			response.sendRedirect("../member/delete.jsp");
		else if (action.equals("/memberList.do"))
			response.sendRedirect("../member/memberList.jsp");
		else if (action.equals("/updateAdmin.do"))
			response.sendRedirect("../member/updateAdmin.jsp");

	}

}

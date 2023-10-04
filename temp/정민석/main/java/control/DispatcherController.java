package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jmsboard.JmsController;
import member.MemberController;

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
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (uri.split("/", 4)[2].equals("home")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.html");
			}
		} else if (uri.split("/", 4)[2].equals("jmsboard")) {
			JmsController jms=new JmsController();
			jms.process(request, response);
		} else if (uri.split("/", 4)[2].equals("member")) {
			MemberController memberControl = new MemberController();
			memberControl.memberProcess(request, response);
		}
	}
}

package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jhBoard.jhBoardJson;
import member.MemberJson;
import qna.QnaJson;

@WebServlet("*.json")
public class JsonAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		response.setContentType("application/x-json; charset=UTF-8");
		process(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		// 한글 처리
		response.setContentType("application/x-json; charset=UTF-8");
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (uri.split("/",4)[2].equals("jhBoard")) {
			jhBoardJson boardJson = new jhBoardJson();
			boardJson.boardProcess(request, response);
		}
		
		else if (uri.split("/",4)[2].equals("login") || (uri.split("/",4)[2].equals("member"))) {
			MemberJson memberJson = new MemberJson();
			memberJson.memberProcess(request, response);			
		}
		
		else if (uri.split("/",4)[2].equals("qna")) {
			QnaJson qnaJson = new QnaJson();
			qnaJson.qnaProcess(request, response);			
		}
		
	}	
}

package control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import board.BoardDAO;
import board.BoardDAOImpl;
import board.BoardDTO;
import board.BoardJson;
import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;
import member.MemberJson;
import qna.QnaJson;

@WebServlet("*.json")
public class JsonAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BoardDAO bDao = new BoardDAOImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		MemberJson memberJson = new MemberJson();
		memberJson.memberProcess(request, response);
		
		BoardJson boardJson = new BoardJson();
		boardJson.boardProcess(request, response);
		
		QnaJson qnaJson = new QnaJson();
		qnaJson.qnaProcess(request, response);
	}
}

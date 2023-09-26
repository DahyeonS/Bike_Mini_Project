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

import board.BoardController;
import member.MemberController;
import member.MemberDTO;
import member.MemberService;
import member.MemberServiceImpl;

@WebServlet("*.json")
public class JsonAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberService service = new MemberServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		MemberController memberControl = new MemberController();
		memberControl.memberProcess(request, response);
		
		BoardController boardControl = new BoardController();
		boardControl.boardProcess(request, response);
	}
}

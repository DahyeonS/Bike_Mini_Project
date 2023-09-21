package member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("*.json")
public class JsonAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		System.out.println("process");
		response.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		System.out.println(uri); // /myweb/memberList.do
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if(action.equals("/memberListData.json")) {
			System.out.println(action); // /memberList.do		
			MemberDAO dao = new MemberDAO();
			List<MemberDTO> list = dao.getMemberList();
			
			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}else if(action.equals("/getMemberJson.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			MemberDAO dao = new MemberDAO();
			dto = dao.getMember(dto);
			String rs = "0";
			if(dto != null) rs = "1";
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}else if(action.equals("/getMemberNameJson.json")) {
			String name = request.getParameter("name");
			
			MemberDTO dto = new MemberDTO();
			dto.setName(name);
			MemberDAO dao = new MemberDAO();
			List<MemberDTO> list = dao.getMemberListName(dto);
			
			String gson = new Gson().toJson(list);
			response.getWriter().write(gson);
		}
		
	}

}

package member;

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
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/login.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			
			if (dto != null) {
				if (pw.equals(dto.getPw())) {
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					session.setAttribute("nickname", dto.getNickname());
					session.setAttribute("grade", dto.getGrade());
					jsonObject.addProperty("rs", 1);
				}
			}
			else jsonObject.addProperty("rs", 0);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/idCheck.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			if(dto != null) jsonObject.addProperty("rs", 1);
			else jsonObject.addProperty("rs", 0);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/join.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO(id, pw, nickname);
			
			int rs = 0;
			rs = service.insert(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/pwShow.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("pw", dto.getPw());
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/update.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO(id, pw, nickname);
			int rs = 0;
			rs = service.update(dto);
			
			JsonObject jsonObject = new JsonObject();
			if (rs == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("nickname", dto.getNickname());
			}
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/delete.json")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			int rs = 0;
			
			if (pw.equals(dto.getPw())) {
				session.invalidate();
				rs = service.delete(dto);
			}
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/memberList.json")) {
			List<MemberDTO> list = service.getMemberList();
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/memberShow.json")) {
			String context = request.getParameter("context");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(context);
			dto.setNickname(context);
			dto = service.memberSearch(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", dto.getId());
			jsonObject.addProperty("pw", dto.getPw());
			jsonObject.addProperty("nickname", dto.getNickname());
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/updateAdmin.json")) {
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String grade = request.getParameter("grade");
			
			MemberDTO dto = new MemberDTO(id, null, nickname, grade);
			int rs = 0;
			rs = service.updateAdmin(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/deleteAdmin.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			int rs = 0;
			rs = service.delete(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/writeJson.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = service.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			
			if (dto != null) {
				if (id.equals(dto.getId())) {
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					session.setAttribute("nickname", dto.getNickname());
					session.setAttribute("grade", dto.getGrade());
					jsonObject.addProperty("rs", 1);
				}
				else jsonObject.addProperty("rs", 0);
				response.getWriter().write(jsonObject.toString());
			}
		}
	}
}

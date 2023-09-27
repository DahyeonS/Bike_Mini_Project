package novel;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;

public class BoardJson {
	MemberDAO Mdao = new MemberDAOImpl();
	BoardDAO Bdao = new BoardDAOImpl();
	
	public void boardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/boardJson.json")) {
			String id = request.getParameter("id");
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = Mdao.getMember(dto);
			String rs = "0";
			if(dto != null) {
				rs = "1";
			} else if (dto == null)rs = "0";
		}
		
		else if (action.equals("/viewJson.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = Mdao.getMember(dto);
			
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
		else if (action.equals("/board.json")) {
			List<BoardDTO> list = Bdao.getPostList();
			
			JsonArray jsonArray = new JsonArray();
			for(BoardDTO dto: list){
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("id", dto.getId());
				jsonObject.addProperty("num", dto.getNum());
				jsonObject.addProperty("nickname", dto.getNickname());	
				jsonObject.addProperty("title", dto.getTitle());	
				jsonObject.addProperty("visit_count", dto.getVisitCount());	
				jsonObject.addProperty("postdate", dto.getPostdate());	
				jsonArray.add(jsonObject);
			}
			
			response.setContentType("text/html; charset=UTF-8");
		    response.getWriter().write(jsonArray.toString());			
		} 
	}
}

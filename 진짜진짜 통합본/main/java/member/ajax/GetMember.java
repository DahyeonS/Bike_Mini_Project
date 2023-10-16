package member.ajax;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

@WebServlet("/getMember.json")
public class GetMember extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		MemberDAO dao = new MemberDAO();
		dto = dao.getMember(dto);
				
		Map<String, MemberDTO> map = new HashMap<>();
		map.put("rs", dto);
		
		String gson = new Gson().toJson(map);
		System.out.println(gson);
		response.getWriter().write(gson);
	}

}

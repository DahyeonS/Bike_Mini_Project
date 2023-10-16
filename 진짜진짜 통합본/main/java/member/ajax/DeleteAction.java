package member.ajax;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

@WebServlet("/deleteAction.json")
public class DeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String pw = request.getParameter("pw");
		
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		MemberDAO dao = new MemberDAO();
		dto = dao.getMember(dto);
		
		int rs = 0;
		if (dto.getPw().equals(pw)) {
			rs = dao.delete(dto);
			session.invalidate();			
		} 
		
		Map<String, String> map = new HashMap<>();
		map.put("rs", rs+"");
		
		String gson = new Gson().toJson(map);
		
		response.getWriter().write(gson);
	}

}

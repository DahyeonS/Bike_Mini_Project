package pcgpkg;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class PcgJson {
	PcgBoardDAO dao = new PcgBoardDAO() {
	};

	public void pcgProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println("pcgProcess");

		if (action.equals("/boardListData.json")) {
			List<PcgBoardDTO> list = dao.pcggetBoardList();
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);

		} else if (action.equals("/boardListSearchData.json")) {
			String title = request.getParameter("title");

			PcgBoardDTO dto = new PcgBoardDTO();
			dto.setTitle(title);

			List<PcgBoardDTO> list = dao.pcggetBoardListSearchData(dto);

			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/pcgInsertboard.json")) {
			
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String category = request.getParameter("category");
			
			PcgBoardDTO dto = new PcgBoardDTO();
			
			dto.setId(id);
			dto.setNickname(nickname);
			dto.setTitle(title);
			dto.setContext(context);
			dto.setCategory(category);

			int rs = dao.pcgInsertboard(dto);
			
			JsonObject jsonObject = new JsonObject();
			
			jsonObject.addProperty("rs", rs);
			

//			String gson = new Gson().toJson(rs);
			System.out.println(jsonObject);
//			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString()); // 글쓰기 제이슨
		}
	}
}

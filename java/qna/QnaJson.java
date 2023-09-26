package qna;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class QnaJson {
	QnaDAO dao = new QnaDAOImpl();
	
	public void qnaProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/qnaBoardList.json")) {
			List<QnaDTO> list = dao.getBoardList();
			if (list.size() == 0) list.add(new QnaDTO());
				
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaBoardListTitle.json")) {
			String title = request.getParameter("title");
			
			QnaDTO dto = new QnaDTO();
			dto.setTitle(title);
			
			List<QnaDTO> list = dao.getBoardListTitle(dto);
			if (list.size() == 0) list.add(dto);
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaBoardListContext.json")) {
			String context = request.getParameter("context");
			
			QnaDTO dto = new QnaDTO();
			dto.setContext(context);
			
			List<QnaDTO> list = dao.getBoardListContext(dto);
			if (list.size() == 0) list.add(dto);
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaBoardListNickname.json")) {
			String nickname = request.getParameter("nickname");
			
			QnaDTO dto = new QnaDTO();
			dto.setNickname(nickname);
			
			List<QnaDTO> list = dao.getBoardListNickname(dto);
			if (list.size() == 0) list.add(dto);
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaBoardView.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			dto = dao.getBoardNum(dto);
			
			String gson = new Gson().toJson(dto);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaDeleteBoard.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			int rs = dao.deleteBoard(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
	}
}

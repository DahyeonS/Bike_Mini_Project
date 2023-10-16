package member.ajax;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import member.common.CommonUtil;
import member.dao.MemberDAO;
import member.dto.MemberDTO;
import member.dto.PagingDTO;

@WebServlet("/getMemberPasingList.json")
public class GetMemberPagingList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String page = request.getParameter("page");
		int pageNum = 1;
		if(page != null) {
			pageNum = Integer.parseInt(page);			
		}
		int listNum = CommonUtil.listNum;
		int blockNum = CommonUtil.blockNum;
		
		// 검색을 위해 필요
		Map<String,String> search = new HashMap<>();
		search.put("searchSelect", "name");
		search.put("searchText", "");
		MemberDAO dao = new MemberDAO();
		int totalCount = dao.getMemberCount(search);
		
		List<MemberDTO> list = dao.getMemberListPaging(pageNum, listNum, search);
		PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
		paging.setPaging();
		System.out.println(paging);
		Map<String, Object> map = new HashMap<>();
		if(list.size() ==0) {
			map.put("rs", "0");
			map.put("paging", "0");
		}else {
			map.put("rs", list);
			map.put("paging", paging);
		}
		
		String gson = new Gson().toJson(map);
		System.out.println(gson);
		response.getWriter().write(gson);
	}

}

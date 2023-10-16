package member.mvc.jstl;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dto.MemberDTO;
import member.dto.PagingDTO;

public class MemberController{
		
	protected void requestMapping(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberController - requestMapping");
		
		IMemberService service = new MemberServiceImpl();
		HttpSession session = request.getSession();
		String view = "";
		
		if(action.equals("/main.go")) {
			System.out.println("/main.go");
			
			view = "main.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/memberList.go")) {
			System.out.println("/memberList.go");
			
			List<MemberDTO> list = service.getMemberList();
			
			PagingDTO paging = new PagingDTO(165, 1, 10, 10);
			paging.setPaging();	
			
			request.setAttribute("list", list);
			request.setAttribute("paging", paging);
			
			
			
			view = "memberList.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/join.go")) {			
			System.out.println("/join.go");
			
			view = "join.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/login.go")) {
			System.out.println("/login.go");
			
			view = "login.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/joinAction.go")) {
			System.out.println("/joinAction.go");
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = service.insert(dto);
			
			view = "login.go";			
			viewResolver(view, request, response);
			
		}else if(action.equals("/loginAction.go")) {
			System.out.println("/loginAction.go"); 
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = service.getMember(dto);
			
			if (dto != null) {
				if (dto.getPw().equals(pw)) {
					
					session.setAttribute("id", id);
					session.setAttribute("name", dto.getName());
					
					view = "main.go";
				} else {
					view = "login.go";
				}
			} else {
				view = "login.go";
			}
			viewResolver(view, request, response);
			
		}else if(action.equals("/logout.go")) {
			System.out.println("/logout.go");
			
			session.invalidate();
			
			view = "main.go";
			viewResolver(view, request, response);
			
		}else if(action.equals("/update.go")) {
			System.out.println("/update.go");
			
			String id = (String)session.getAttribute("id");

			MemberDTO dto = new MemberDTO();
			dto.setId(id);

			dto = service.getMember(dto);
			
			request.setAttribute("dto", dto);
			
			view = "update.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/updateAction.go")) {
			System.out.println("/updateAction.go");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = service.update(dto);
			
			session.setAttribute("name", name);
			
			view = "update.go";
			viewResolver(view, request, response);
			
		}else if(action.equals("/delete.go")) {			
			System.out.println("/delete.go");
			
			view = "delete.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/deleteAction.go")) {			
			System.out.println("/deleteAction.go");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = service.getMember(dto);
			
			if (dto.getPw().equals(pw)) {
				
				service.delete(dto);
				session.invalidate();
				
				view = "main.go";
				
			} else {
				
				view = "delete.go";
			}		
			
			viewResolver(view, request, response);
			
		}		
	}

	void viewResolver(String view, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String viewExt = view.split("\\.")[1];
		
		if(viewExt.equals("jsp")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}else {
			response.sendRedirect(view);
		}
		
	}
}

package member.mybatis.inter;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.dto.MemberDTO;


public class MemberController{
		
	protected void requestMapping(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberController - requestMapping");
		
		IMemberService service = new MemberServiceImpl();
		HttpSession session = request.getSession();
		String view = "";
		
		if(action.equals("/main.mi")) {
			System.out.println("/main.mi");
			
			view = "main.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/memberList.mi")) {
			System.out.println("/memberList.mi");
			
			List<MemberDTO> list = service.getMemberList();
			
			request.setAttribute("list", list);
			
			view = "memberList.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/join.mi")) {			
			System.out.println("/join.mi");
			
			view = "join.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/login.mi")) {
			System.out.println("/login.mi");
			
			view = "login.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/joinAction.mi")) {
			System.out.println("/joinAction.mi");
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = service.insert(dto);
			
			view = "login.mi";			
			viewResolver(view, request, response);
			
		}else if(action.equals("/loginAction.mi")) {
			System.out.println("/loginAction.mi"); 
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = service.getMember(dto);
			
			if (dto != null) {
				if (dto.getPw().equals(pw)) {
					
					session.setAttribute("id", id);
					session.setAttribute("name", dto.getName());
					
					view = "main.mi";
				} else {
					view = "login.mi";
				}
			} else {
				view = "login.mi";
			}
			viewResolver(view, request, response);
			
		}else if(action.equals("/logout.mi")) {
			System.out.println("/logout.mi");
			
			session.invalidate();
			
			view = "main.mi";
			viewResolver(view, request, response);
			
		}else if(action.equals("/update.mi")) {
			System.out.println("/update.mi");
			
			String id = (String)session.getAttribute("id");

			MemberDTO dto = new MemberDTO();
			dto.setId(id);

			dto = service.getMember(dto);
			
			request.setAttribute("dto", dto);
			
			view = "update.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/updateAction.mi")) {
			System.out.println("/updateAction.mi");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = service.update(dto);
			
			session.setAttribute("name", name);
			
			view = "update.mi";
			viewResolver(view, request, response);
			
		}else if(action.equals("/delete.mi")) {			
			System.out.println("/delete.mi");
			
			view = "delete.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/deleteAction.mi")) {			
			System.out.println("/deleteAction.mi");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = service.getMember(dto);
			
			if (dto.getPw().equals(pw)) {
				
				service.delete(dto);
				session.invalidate();
				
				view = "main.mi";
				
			} else {
				
				view = "delete.mi";
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

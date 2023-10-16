package member.mybatis.xml;

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
		
		if(action.equals("/main.mx")) {
			System.out.println("/main.mx");
			
			view = "main.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/memberList.mx")) {
			System.out.println("/memberList.mx");
			
			List<MemberDTO> list = service.getMemberList();
			
			request.setAttribute("list", list);
			
			view = "memberList.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/join.mx")) {			
			System.out.println("/join.mx");
			
			view = "join.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/login.mx")) {
			System.out.println("/login.mx");
			
			view = "login.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/joinAction.mx")) {
			System.out.println("/joinAction.mx");
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = service.insert(dto);
			
			view = "login.mx";			
			viewResolver(view, request, response);
			
		}else if(action.equals("/loginAction.mx")) {
			System.out.println("/loginAction.mx"); 
			
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = service.getMember(dto);
			
			if (dto != null) {
				if (dto.getPw().equals(pw)) {
					
					session.setAttribute("id", id);
					session.setAttribute("name", dto.getName());
					
					view = "main.mx";
				} else {
					view = "login.mx";
				}
			} else {
				view = "login.mx";
			}
			viewResolver(view, request, response);
			
		}else if(action.equals("/logout.mx")) {
			System.out.println("/logout.mx");
			
			session.invalidate();
			
			view = "main.mx";
			viewResolver(view, request, response);
			
		}else if(action.equals("/update.mx")) {
			System.out.println("/update.mx");
			
			String id = (String)session.getAttribute("id");

			MemberDTO dto = new MemberDTO();
			dto.setId(id);

			dto = service.getMember(dto);
			
			request.setAttribute("dto", dto);
			
			view = "update.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/updateAction.mx")) {
			System.out.println("/updateAction.mx");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String role = request.getParameter("role");
			MemberDTO dto = new MemberDTO(id, pw, name, role);
			
			int rs = service.update(dto);
			
			session.setAttribute("name", name);
			
			view = "update.mx";
			viewResolver(view, request, response);
			
		}else if(action.equals("/delete.mx")) {			
			System.out.println("/delete.mx");
			
			view = "delete.jsp";
			viewResolver(view, request, response);
			
		}else if(action.equals("/deleteAction.mx")) {			
			System.out.println("/deleteAction.mx");
			
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			
			dto = service.getMember(dto);
			
			if (dto.getPw().equals(pw)) {
				
				service.delete(dto);
				session.invalidate();
				
				view = "main.mx";
				
			} else {
				
				view = "delete.mx";
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

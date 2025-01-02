package com.gentlemonster.web.handler;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.MemberDAO;

@RequestMapping("/member/login")
public class LoginHandler implements CommandHandler{

	private MemberDAO memberDAO;
	
	public LoginHandler() {
		memberDAO = new MemberDAO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String userid = request.getParameter("userid");
			String password = request.getParameter("password");
			HttpSession session = request.getSession();
			
			try {
				String dbpw = memberDAO.getPassword(userid);

				if (dbpw.equals(password)) {
					session.setAttribute("userid", userid);
				} else {
					throw new RuntimeException("비밀번호가 다릅니다.");
				}
			} catch(RuntimeException e) {
				session.invalidate();
				e.printStackTrace();
			}
			return "redirect:/shop?bigCategoryId=1&smallCategoryId=view-all";
		} else {
			return "/shop/sunglassesList.jsp";
		}	
	}
	
}

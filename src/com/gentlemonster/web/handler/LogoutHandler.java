package com.gentlemonster.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;

@RequestMapping("/member/logout")
public class LogoutHandler implements CommandHandler{

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.invalidate();
			}
			
			return "redirect:/shop?bigCategoryId=1&smallCategoryId=view-all";
		}else {
			return "/shop/sunglassesList.jsp";
		}	
	}

}

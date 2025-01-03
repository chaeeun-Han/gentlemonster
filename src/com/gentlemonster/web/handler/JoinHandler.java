package com.gentlemonster.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.MemberDAO;
import com.gentlemonster.web.dto.MemberDTO;

@RequestMapping("/member/join")
public class JoinHandler implements CommandHandler{

	private MemberDAO memberDAO;
	
	public JoinHandler() {
		memberDAO = new MemberDAO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		if ("POST".equalsIgnoreCase(request.getMethod())) {
			String userid = request.getParameter("userid");
			String password = request.getParameter("password");
			String passwordCheck = request.getParameter("passwordCheck");
			String birthday = request.getParameter("birthday");
			String email = request.getParameter("email");
			String address = request.getParameter("address");
			MemberDTO member = new MemberDTO();
			member.setUserid(userid);
			member.setPassword(password);
			member.setPasswordCheck(passwordCheck);
			member.setBirthday(birthday);
			member.setEmail(email);
			member.setAddress(address);
			memberDAO.join(member);
			
			return "redirect:/shop?bigCategoryId=1&smallCategoryId=view-all";
		} else {
			return "/member/join.jsp";
		}
	}

}

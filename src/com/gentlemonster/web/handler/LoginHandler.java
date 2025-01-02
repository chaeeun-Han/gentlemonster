package com.gentlemonster.web.handler;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dto.CustomerDTO;

@RequestMapping("/login")
public class LoginHandler implements CommandHandler{

	CustomerDTO customer;
	public LoginHandler() {
		customer = new CustomerDTO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		
		// 로그인 기능 구현 시 바뀌어야 할 부분
		customer.setCustomerId(1L);
		customer.setUserId("id");
		customer.setUserPw("password");
		customer.setBirthday(new Timestamp(System.currentTimeMillis()));
		customer.setEmail("metanet@naver.com");
		customer.setAddress("서울");
		
		
		HttpSession session = request.getSession();
		session.setAttribute("customer", customer);
		
		return "/shop/sunglassesList.jsp";
			
	}
	
}

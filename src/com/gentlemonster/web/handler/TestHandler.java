package com.gentlemonster.web.handler;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.TestDAO;


@RequestMapping("/shop/test")
public class TestHandler implements CommandHandler {
	
	private TestDAO testDAO;
	
	public TestHandler() {
		testDAO = new TestDAO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		String count = testDAO.test();
		request.setAttribute("count", count);
		return "/shop/test.jsp";
	}
}

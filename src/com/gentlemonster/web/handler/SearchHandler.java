package com.gentlemonster.web.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.SearchDAO;
import com.gentlemonster.web.dto.SearchDTO;
import com.gentlemonster.web.dto.TrendDTO;

@RequestMapping("/shop/search")
public class SearchHandler implements CommandHandler{

	private SearchDAO searchDAO;
	
	public SearchHandler() {
		searchDAO = new SearchDAO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		String term = request.getParameter("term");
		if(term != null) {
			List<SearchDTO> searchList = searchDAO.search(term);
			
			request.setAttribute("term", term);
			request.setAttribute("size", searchList.size());
			request.setAttribute("searchList", searchList);
			
			return "/searchResult.jsp";
		}
		
		List<TrendDTO> trendList = searchDAO.getTrend();
		request.setAttribute("trendList", trendList);
		
		return "/shop/search.jsp";
	}
}
	
package com.gentlemonster.web.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.StyleDAO;
import com.gentlemonster.web.dto.StyleDTO;

@RequestMapping("/styles")
public class StyleHandler implements CommandHandler{
	
	private StyleDAO styleDAO;
	
	public StyleHandler() {
		styleDAO = new StyleDAO();
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		List<StyleDTO> styles = styleDAO.getStyleList();
		request.setAttribute("styles", styles);
		return "/styles/list.jsp";
	}

}

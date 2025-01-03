package com.gentlemonster.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.ProductDAO;
import com.gentlemonster.web.dao.StyleDAO;
import com.gentlemonster.web.dto.ProductDTO;
import com.gentlemonster.web.dto.StyleDTO;

@RequestMapping("/styles/detail")
public class StyleDetailHandler implements CommandHandler {

    private ProductDAO productDAO;
    private StyleDAO styleDAO;

    public StyleDetailHandler() {
        productDAO = new ProductDAO();
        styleDAO = new StyleDAO();
    }

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
    	String productId = request.getParameter("id");
    	request.setAttribute("productId", productId);
    	ProductDTO product = productDAO.getItem(productId);
    	StyleDTO style = styleDAO.getStyle(productId);
		request.setAttribute("product", product);
		request.setAttribute("style", style);
        return "/styles/detail.jsp";
    }
}

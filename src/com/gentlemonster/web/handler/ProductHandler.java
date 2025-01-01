package com.gentlemonster.web.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.ProductDAO;
import com.gentlemonster.web.dto.ProductDTO;


@RequestMapping("/shop")
public class ProductHandler implements CommandHandler{
	
	private ProductDAO productDAO;
	
	public ProductHandler() {
		productDAO = new ProductDAO();
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		String bigCategoryId = request.getParameter("bigCategoryId");
		String smallCategoryId = request.getParameter("smallCategoryId");
		
		List<ProductDTO> productList = productDAO.getItemList(bigCategoryId, smallCategoryId);
		request.setAttribute("productList", productList);
		
		if ("1".equals(bigCategoryId)) {
			return "/shop/sunglassesList.jsp";
		}
		else {
			return "/shop/glassesList.jsp";
		}
	}

}

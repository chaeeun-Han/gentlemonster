package com.gentlemonster.web.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.PurchaseHistoryDAO;
import com.gentlemonster.web.dto.PurchaseHistoryDTO;
import com.gentlemonster.web.dto.PurchaseInformationDTO;

@RequestMapping("/shop/purchase-history")
public class PurchaseHistoryHandler implements CommandHandler{
	
	private PurchaseHistoryDAO purchaseHistoryDAO;
	
	public PurchaseHistoryHandler() {
		purchaseHistoryDAO = new PurchaseHistoryDAO();
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		Long purchaseId = Long.valueOf(request.getParameter("id"));
		List<PurchaseHistoryDTO> products = purchaseHistoryDAO.getProductList(purchaseId);
		int totalProductPrice = 0;
		int shippingFee = 0;
		int totalCount = 0;
		PurchaseInformationDTO information = purchaseHistoryDAO.getPurchaseInformation(purchaseId);

		for (PurchaseHistoryDTO product : products) {
			totalProductPrice += product.getPrice();
			totalCount += product.getProductCount();
		}
		int totalPrice = totalProductPrice + shippingFee;
		
		request.setAttribute("products", products);
		request.setAttribute("totalProductPrice", totalProductPrice);
		request.setAttribute("shippingFee", shippingFee);
		request.setAttribute("totalPrice", totalPrice);
		request.setAttribute("purchaseId", purchaseId);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("information", information);
		
		return "/shop/purchaseHistory.jsp";
	}
}

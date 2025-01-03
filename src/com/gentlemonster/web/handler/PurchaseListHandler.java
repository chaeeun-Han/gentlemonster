package com.gentlemonster.web.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.PurchaseDAO;
import com.gentlemonster.web.dto.CustomerDTO;
import com.gentlemonster.web.dto.PurchaseListDTO;

@RequestMapping("/shop/purchase-list")
public class PurchaseListHandler implements CommandHandler{

	private PurchaseDAO purchaseListDAO;
	
	public PurchaseListHandler() {
		purchaseListDAO = new PurchaseDAO();
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {

		CustomerDTO customer = (CustomerDTO) request.getSession().getAttribute("customer");
		if (customer == null) {
			throw new RuntimeException("로그인한 사용자가 없습니다.");
		}
		Long customerId = customer.getCustomerId();
		
		List<PurchaseListDTO> purchaseList = purchaseListDAO.getPurchaseList(customerId);
		request.setAttribute("purchaseList", purchaseList);
		
		return "shop/purchaseList.jsp";
	}

}

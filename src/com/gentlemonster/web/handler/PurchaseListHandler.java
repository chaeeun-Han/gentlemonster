package com.gentlemonster.web.handler;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.PurchaseListDAO;
import com.gentlemonster.web.dto.CustomerDTO;
import com.gentlemonster.web.dto.PurchaseListDTO;

@RequestMapping("/shop/purchase-list")
public class PurchaseListHandler implements CommandHandler{

	private PurchaseListDAO purchaseListDAO;
	
	public PurchaseListHandler() {
		purchaseListDAO = new PurchaseListDAO();
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userid");
		
		List<PurchaseListDTO> purchaseList = purchaseListDAO.getPurchaseList(userId);
		request.setAttribute("purchaseList", purchaseList);
		
		return "shop/purchaseList.jsp";
	}

}

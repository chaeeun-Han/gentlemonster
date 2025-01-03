package com.gentlemonster.web.handler;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.PurchaseDAO;
import com.gentlemonster.web.dao.PurchaseHistoryDAO;
import com.gentlemonster.web.dto.CustomerDTO;
import com.gentlemonster.web.dto.PurchaseHistoryDTO;
import com.gentlemonster.web.dto.PurchaseInformationDTO;

@RequestMapping("/shop/purchase")
public class PurchaseHandler implements CommandHandler{
	private PurchaseDAO purchaseDAO;
	private PurchaseHistoryDAO PurchaseHistoryDAO;
	CustomerDTO seesionCustomer;

	public PurchaseHandler() {
		purchaseDAO = new PurchaseDAO();
		PurchaseHistoryDAO = new PurchaseHistoryDAO();
		
		// 임시 세션 생성
		seesionCustomer = new CustomerDTO();
		seesionCustomer.setCustomerId(1L);
		seesionCustomer.setUserId("id");
		seesionCustomer.setUserPw("password");
		seesionCustomer.setBirthday(new Timestamp(System.currentTimeMillis()));
		seesionCustomer.setEmail("metanet@naver.com");
		seesionCustomer.setAddress("서울");
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
		// 이동한 페이지
		String view = "/shop/purchase.jsp";

		// 세션을 통해서 고객 정보 가져오기
		HttpSession session = request.getSession();
		session.setAttribute("customer", seesionCustomer); // 제거 예정
		CustomerDTO customer = (CustomerDTO) session.getAttribute("customer");
		
		if("GET".equals(request.getMethod())) { // GET 요청 - 구매 페이지 반환			
			// 고객의 주소 화면에 출력
			request.setAttribute("customer", customer);
			
			// TODO : 고객이 주문한 상품 화면에 출력
			
			// view 설정
			view = "/shop/purchase.jsp";
		} else if("POST".equals(request.getMethod())) { // POST 요청 - 구매하기 후 완료 텍스트 띄우기
			// attribute를 통해서 구매할 물건 목록 불러오기
			List<PurchaseHistoryDTO> products = (List<PurchaseHistoryDTO>)session.getAttribute("products");
//			for(PurchaseHistoryDTO purchase : products) {
//				System.out.println(purchase);
//			}
			
			// 구매 정보 받아오기
			LocalDateTime purchaseTime = LocalDateTime.now();
			int totalPrice = products.stream().mapToInt(o -> o.getPrice()).sum();
			String receiver = request.getParameter("first") + request.getParameter("last");
			String phoneNumber = request.getParameter("phone");
			String address = request.getParameter("address");
			PurchaseInformationDTO purchase = new PurchaseInformationDTO(
					purchaseTime,
					totalPrice,
					receiver,
					phoneNumber,
					address
			);
			
			// 구매하기
			Long purchaseId = purchaseDAO.postPurchase(purchase, customer);
			
			// 구매한 목록 저장하기
			PurchaseHistoryDAO.postPurchaseHistorys(products, purchaseId);

			// view 설정
			view = "redirect:purchase-history?id="+purchaseId;
		}
		
		return view;
	}
}

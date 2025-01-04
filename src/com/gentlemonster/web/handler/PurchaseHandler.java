package com.gentlemonster.web.handler;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.ImageDAO;
import com.gentlemonster.web.dao.MemberDAO;
import com.gentlemonster.web.dao.PurchaseDAO;
import com.gentlemonster.web.dao.PurchaseHistoryDAO;
import com.gentlemonster.web.dto.CustomerDTO;
import com.gentlemonster.web.dto.ImageDTO;
import com.gentlemonster.web.dto.ProductDTO;
import com.gentlemonster.web.dto.PurchaseHistoryDTO;
import com.gentlemonster.web.dto.PurchaseInformationDTO;


@RequestMapping("/shop/purchase")
public class PurchaseHandler implements CommandHandler{
	private PurchaseDAO purchaseDAO;
	private PurchaseHistoryDAO purchaseHistoryDAO;
	private MemberDAO memberDAO;
	private ImageDAO imageDAO;

	public PurchaseHandler() {
		purchaseDAO = new PurchaseDAO();
		purchaseHistoryDAO = new PurchaseHistoryDAO();
		memberDAO = new MemberDAO();
		imageDAO = new ImageDAO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) {
	    try {
	        // POST 요청 본문 인코딩 설정
	        request.setCharacterEncoding("UTF-8");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

        // 이동한 페이지
		String view = "/shop/purchase.jsp";

		// 세션을 통해서 고객 정보 가져오기
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userid") == null) { // 로그인이 되지 않은 상태
			// TODO : 로그인 모달창 띄우기
			return "redirect:/shop?bigCategoryId=1&smallCategoryId=view-all";
		}

		// 사용자 ID
		Long customerId = Long.valueOf((String) session.getAttribute("userid"));
		
		if("GET".equals(request.getMethod())) { // GET 요청 - 구매 페이지 반환			
			// 고객의 주소 화면에 출력
			request.setAttribute("address", memberDAO.getCustomer(customerId).getAddress());
			
			// 파라미터값들을  List<PurchaseHistoryDTO>로 파싱하는 메서드
			List<PurchaseHistoryDTO> products = parseToProducts(request);
			request.setAttribute("products", products);

			// TODO : 고객이 주문한 상품 화면(장바구니)에 출력
			
			
			// view 설정
			view = "/shop/purchase.jsp";            
		} else if("POST".equals(request.getMethod())) { // POST 요청 - 구매하기 후 완료 텍스트 띄우기
			// 파라미터값들을  List<PurchaseHistoryDTO>로 파싱하는 메서드
			List<PurchaseHistoryDTO> products = parseToProducts(request);

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
			CustomerDTO customer = memberDAO.getCustomer(customerId);
			Long purchaseId = purchaseDAO.postPurchase(purchase, customer.getCustomerId());
			
			// 구매한 목록 저장하기
			purchaseHistoryDAO.postPurchaseHistorys(products, purchaseId);

			// view 설정
			view = "redirect:purchase-history?id="+purchaseId;
		}
		
		return view;
	}
	
	// 파라미터값들을  List<PurchaseHistoryDTO>로 파싱하는 메서드
	private List<PurchaseHistoryDTO> parseToProducts(HttpServletRequest request) {
	    String[] productIds = request.getParameterValues("productId");
	    String[] productNames = request.getParameterValues("productName");
	    String[] productCounts = request.getParameterValues("productCount");
	    String[] prices = request.getParameterValues("price");
	    String[] imgUrls = request.getParameterValues("imgUrl");

	    List<PurchaseHistoryDTO> products = new ArrayList<>();
	    if (productIds != null) {
	        for (int i = 0; i < productIds.length; i++) {
	            PurchaseHistoryDTO product = new PurchaseHistoryDTO();
	            product.setProductId(Long.valueOf(productIds[i]));
	            product.setProductName(productNames[i]);
	            product.setProductCount(Integer.valueOf(productCounts[i]));
	            product.setPrice(Integer.valueOf(prices[i]));
	            product.setImgUrl(imgUrls[i]);
	            
	            // 중복된 데이터 저장 방지
	            if (!products.contains(product)) {
	                products.add(product);
	            }
	        }
	    }
	    
	    return products;
	}
}

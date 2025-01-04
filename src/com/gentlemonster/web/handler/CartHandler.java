package com.gentlemonster.web.handler;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.CartDAO;
import com.gentlemonster.web.dao.ProductDAO;
import com.gentlemonster.web.dto.CartDTO;

@RequestMapping("/shop/cart")
public class CartHandler implements CommandHandler{
	private ProductDAO productDAO;
	private CartDAO cartDAO;
	
	public CartHandler() {
		productDAO = new ProductDAO();
		cartDAO = new CartDAO();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response){
		String method = (String) request.getAttribute("method");
	    if (method == null) {
	        method = request.getMethod();
	    }
        System.out.println("Method: " + method);
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();
        String userId = (String) session.getAttribute("userid"); // 세션에서 사용자 ID 가져오기
        
        try {
	        if ("POST".equals(method)) { // 장바구니에 상품 추가
	        	String itemId = request.getParameter("itemid");
	        	System.out.println("itemid : " + itemId);
	        	cartDAO.addToCart(userId, itemId);
	        	return "redirect:/shop/item?id=" + itemId;
	        } 
	        else if ("DELETE".equals(method)) { // 장바구니 상품 삭제
	        	System.out.println("장바구니 delete");
	        	String cartId = request.getParameter("cartid");
	        	System.out.println("cartid : " + cartId);
	        	cartDAO.removeItemFromCart(cartId);
	            return "/shop/cart.jsp";
	        } 
	        else if ("GET".equals(method)) { // 장바구니 상품 조회
	            List<CartDTO> cartList = cartDAO.getCartItemList(userId);
	            request.setAttribute("cartList", cartList);
	            System.out.println(cartList.toString());
	            return "/shop/cart.jsp";
	        } 
	        else if ("UPDATE".equals(method)) { // 상품 수정 
	        	System.out.println("장바구니 update");
	        	List<CartDTO> cartList = new ArrayList<CartDTO>();

	        	BufferedReader reader = request.getReader();
	            StringBuilder jsonBuilder = new StringBuilder();
	            String line;
	            while ((line = reader.readLine()) != null) {
	                jsonBuilder.append(line);
	            }

	            String json = jsonBuilder.toString();

	            if (json.contains("cartId") && json.contains("quantity")) {
	                String[] items = json.substring(json.indexOf("[") + 1, json.lastIndexOf("]")).split("\\},\\{");

	                for (String item : items) {
	                    item = item.replace("[", "").replace("]", "").replace("{", "").replace("}", "").replace("\"", "");
	                    
	                    Long cartId = 0L;
	                    int quantity = 0;

	                    // cartId와 quantity 추출
	                    String[] parts = item.split(",");
	                    for (String part : parts) {
	                        String[] keyValue = part.split(":");
	                        if (keyValue[0].trim().equals("cartId")) {
	                            cartId = Long.parseLong(keyValue[1].trim());
	                            System.out.println("cartId : " + cartId);
	                        } else if (keyValue[0].trim().equals("quantity")) {
	                            quantity = Integer.parseInt(keyValue[1].trim());
	                        }
	                    }

	                    // 장바구니 아이템 업데이트 실행
	                    CartDTO cart = cartDAO.getCartToUpdate(String.valueOf(cartId));
	                    if (cart != null) {
	                    	System.out.println("업데이트할 장바구니 : " + cart.toString());
	                        cart.setProductCount(quantity);
	                        cartList.add(cart);
	                    }
	                }
	                System.out.println("cartList : " + cartList.toString());
	                // 데이터베이스 업데이트
	                if (!cartList.isEmpty()) {
	                    cartDAO.updateCart(cartList);
	                    System.out.println("Cart updated successfully.");
	                } else {
	                    System.out.println("No items to update.");
	                }
	            } else {
	                System.out.println("Invalid request.");
	            }
	        }
        }catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}    
}
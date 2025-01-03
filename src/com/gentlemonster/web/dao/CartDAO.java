package com.gentlemonster.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.gentlemonster.web.dto.CartDTO;

public class CartDAO {
    private static DataSource dataSource;

    static {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    // 장바구니에 있는 상품 갯수 조회하기
    public int getCartCount(String userId) throws Exception {
        String sql = "SELECT COUNT(*) AS cart_count FROM cart WHERE customer_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cart_count");
                }
            }
        }
        return 0; // 기본값 반환
    }
    
    // 상품 장바구니에 저장하기
    public void addToCart(String userId, String itemId) throws Exception {
    	// 이미 저장된 product_id가 있을 경우 count만 올려주기
    	String mergeQuery = 
    		    "MERGE INTO cart c " +
    		    "USING (SELECT ? AS customer_id, ? AS product_id, 1 AS product_count FROM dual) src " +
    		    "ON (c.customer_id = src.customer_id AND c.product_id = src.product_id) " +
    		    "WHEN MATCHED THEN " +
    		    "    UPDATE SET c.product_count = c.product_count + 1 " +
    		    "WHEN NOT MATCHED THEN " +
    		    "    INSERT (customer_id, product_id, product_count) " +
    		    "    VALUES (src.customer_id, src.product_id, src.product_count)";
    	   	
    	try (Connection conn = dataSource.getConnection();
           PreparedStatement pstmt = conn.prepareStatement(mergeQuery)) {
           pstmt.setString(1, userId);
           pstmt.setString(2, itemId);
           int rs = pstmt.executeUpdate();
        } catch(Exception e) {
        	e.printStackTrace();
        }		
    }
    
    // 장바구니에서 상품 삭제하기
    public void removeItemFromCart(String cartId) throws Exception {
    	String deleteQuery = "DELETE FROM cart WHERE cart_id = ?";
        
        try (Connection conn = dataSource.getConnection();
    		PreparedStatement ps = conn.prepareStatement(deleteQuery)) {
            ps.setString(1, cartId); 
            ps.executeUpdate();
        }
    }
    
    // 장바구니 조회하기
    public List<CartDTO> getCartItemList(String userId) throws Exception {
    	String selectQuery = "SELECT " +
                "    c.cart_id, " +
                "    c.customer_id, " +
                "    c.product_id, " +
                "    c.product_count, " +
                "    p.product_name, " +
                "    p.price, " +
                "    p.main_image " +
                "FROM cart c " +
                "JOIN product p ON c.product_id = p.product_id " +
                "WHERE c.customer_id = ?";
    	
    	List<CartDTO> cartList = new ArrayList<>();
        
        try (Connection conn = dataSource.getConnection();
        		PreparedStatement ps = conn.prepareStatement(selectQuery)) {
            ps.setString(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartDTO item = new CartDTO();
                    item.setCartId(rs.getLong("cart_id"));
                    item.setCustomerId(rs.getLong("customer_id"));
                    item.setProductId(rs.getLong("product_id"));
                    item.setProductCount(rs.getInt("product_count"));
                    item.setProductName(rs.getString("product_name"));
                    item.setPrice(rs.getInt("price"));
                    item.setMainImage(rs.getString("main_image"));
                    cartList.add(item);
                }
            }
        } catch (SQLException e) {
        	e.printStackTrace();
        }
		return cartList;
    }
    
    // 장바구니 수량 수정하기
    public void updateCart(List<CartDTO> updates) {
    	// isUpdate = true일 때 fe에서 해당 메소드 실행
    	// product_count를 수정한다.
    	String query = "UPDATE cart SET product_count = CASE cart_id ";

        StringBuilder cases = new StringBuilder();
        StringBuilder ids = new StringBuilder();
        for (CartDTO update : updates) {
            cases.append("WHEN ").append(update.getCartId()).append(" THEN ").append(update.getProductCount()).append(" ");
            ids.append(update.getCartId()).append(",");
        }

        query += cases.toString() + "END WHERE cart_id IN (" + ids.substring(0, ids.length() - 1) + ")";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.executeUpdate();
        } catch (SQLException e) {
			e.printStackTrace();
		}
    }
}

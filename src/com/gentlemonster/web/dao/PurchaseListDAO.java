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

import com.gentlemonster.web.dto.PurchaseHistoryDTO;
import com.gentlemonster.web.dto.PurchaseListDTO;

public class PurchaseListDAO {
	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public List<PurchaseListDTO> getPurchaseList(Long customerId) {
		List<PurchaseListDTO> purchaseList = new ArrayList<PurchaseListDTO>();
		Connection con = null;
		//상품명, 개수, 가격
		//purchase.purchase_time, purchase.purchase_id, purchase_history.product_count, purchase_history.price, prd.price, i.image_url 
		try {
			con = dataSource.getConnection();
			String sql = "select purchase_id, to_char(purchase_time, 'YYYY-MM-DD') as purchase_time "
					+ "from purchase "
					+ "where customer_id=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setLong(1, customerId);
			
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				List<PurchaseHistoryDTO> purchaseHistoryList = new ArrayList<PurchaseHistoryDTO>();
				PurchaseListDTO dto = new PurchaseListDTO();
				dto.setPurchaseId(rs.getLong("purchase_id"));
				dto.setPurchaseTime(rs.getString("purchase_time"));
				
				String sql2 = "select prd.product_name, ph.product_count, ph.price, prd.main_image "
						+ "from payment_history ph "
						+ "join product prd "
						+ "on ph.product_id=prd.product_id "
						+ "where ph.purchase_id=?";
				PreparedStatement stmt2 = con.prepareStatement(sql2);
				stmt2.setLong(1, dto.getPurchaseId());
				ResultSet rs2 = stmt2.executeQuery();

				while(rs2.next()) {
					PurchaseHistoryDTO historyDto = new PurchaseHistoryDTO();
					historyDto.setProductName(rs2.getString("product_name"));
					historyDto.setProductCount(rs2.getInt("product_count"));
					historyDto.setPrice(rs2.getInt("price"));
					historyDto.setImgUrl(rs2.getString("main_image"));
					purchaseHistoryList.add(historyDto);
				}
				dto.setPurchaseHistoryDTO(purchaseHistoryList);
				
				purchaseList.add(dto);
				System.out.println(dto.toString());
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(con);
		}
		
		return purchaseList;
	}
	
	private void closeConnection(Connection con) {
		if(con!=null) {
			try {
				con.close();
			} catch(Exception e) {
				
			}
		}
	}
}

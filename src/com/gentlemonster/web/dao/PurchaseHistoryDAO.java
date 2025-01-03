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
import com.gentlemonster.web.dto.PurchaseInformationDTO;

public class PurchaseHistoryDAO {
	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public List<PurchaseHistoryDTO> getProductList(Long purchase_id) {
		List<PurchaseHistoryDTO> products = new ArrayList<PurchaseHistoryDTO>();
		Connection con = null;

		try {
			con = dataSource.getConnection();
			String sql = "select prd.product_name, ph.product_count, prd.price, prd.main_image "
					+ "from payment_history ph "
					+ "join product prd "
					+ "on ph.product_id=prd.product_id "
					+ "where ph.purchase_id=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setLong(1, purchase_id);
			
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				PurchaseHistoryDTO dto = new PurchaseHistoryDTO();
				dto.setProductName(rs.getString("product_name"));
				dto.setProductCount(rs.getInt("product_count"));
				dto.setPrice(rs.getInt("price") * dto.getProductCount());
				dto.setImgUrl(rs.getString("main_image"));
				products.add(dto);
				System.out.println(dto.toString());
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(con);
		}
		
		return products;
	}
	
	public PurchaseInformationDTO getPurchaseInformation(Long purchase_id) {
		PurchaseInformationDTO purchaseInfo = new PurchaseInformationDTO();
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			
			String sql = "select to_char(purchase_time, 'YYYY-MM-DD HH24:MI:SS') as purchase_time, total_price, received_name, phone_number, address from purchase where purchase_id=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setLong(1, purchase_id);
			
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				purchaseInfo.setPurchaseTime(rs.getString("purchase_time"));
				purchaseInfo.setTotalPrice(rs.getInt("total_price"));
				purchaseInfo.setReceiver(rs.getString("received_name"));
				purchaseInfo.setPhoneNumber(rs.getString("phone_number"));
				purchaseInfo.setAddress(rs.getString("address"));
			} else {
				throw new SQLException("해당 주문 내역이 없습니다.");
			}

		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(con);
		}
		
		return purchaseInfo;
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

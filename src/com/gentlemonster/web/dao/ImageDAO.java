package com.gentlemonster.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.gentlemonster.web.dto.ImageDTO;
import com.gentlemonster.web.dto.ProductDTO;

public class ImageDAO {
	static DataSource dataSource;
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public ProductDTO getProduct(String productId) {
		
		Connection con = null;
		ProductDTO productDTO = new ProductDTO();
		
		try {
			con = dataSource.getConnection();
			String sql = "select product_name, price, color_count, product_count, description, detail "
					+ "from product "
					+ "where product_id = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productId);
			ResultSet rs = pstmt.executeQuery();
			System.out.println("1");
			
			while (rs.next()) {
				productDTO.setProductId(Long.parseLong(productId));
				productDTO.setProductName(rs.getString(1));
				productDTO.setPrice(rs.getString(2));
				productDTO.setColorCount(rs.getInt(3));
				productDTO.setProductCount(rs.getInt(4));
				productDTO.setDiscription(rs.getString(5));
				productDTO.setDetail(rs.getString(6));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		
		return productDTO; 
	}

	public List<ImageDTO> getImage(String productId) {

		Connection con = null;
		List<ImageDTO> list = new ArrayList<>();
		try {
			con = dataSource.getConnection();
			String sql = "select * " + "from image where product_id = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productId);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				ImageDTO imageDTO = new ImageDTO();
				imageDTO.setImageId(rs.getLong(1));
				imageDTO.setProductId(rs.getLong(2));
				imageDTO.setImageUrl(rs.getString(3));
				list.add(imageDTO);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		return list;
	}
	
	public List<String> getSimilarProduct(String productId) {

		Connection con = null;
		List<String> mainImage = new ArrayList<>();
		try {
			// 같은 종류의 다른 색상의 product name을 가져오는 과정
			con = dataSource.getConnection();
			String sql = "select product_name " 
						+ "from image "
						+ "where product_id = ? "
						;
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, productId);

			ResultSet rs = pstmt.executeQuery();
			List<String> nameList = new ArrayList<>();
			StringTokenizer st = new StringTokenizer(rs.getString(1), " ");
			String firstName = st.nextToken();
			
			sql = "select main_image " 
						+ "from product "
						+ "where product_name like "
						+ firstName + "%"
						;
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				mainImage.add(rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		return mainImage;
	}

	private void closeConnection(Connection con) {
		if (con != null) {
			try {
				con.close();
			} catch (Exception e) {
				// nothing
			}
		}
	}
}
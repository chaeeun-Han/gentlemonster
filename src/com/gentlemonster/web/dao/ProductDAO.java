package com.gentlemonster.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.gentlemonster.web.dto.ProductDTO;



public class ProductDAO {
	static DataSource dataSource;

	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}

	public List<ProductDTO> getItemList(String bigCategoryId, String smallCategoryId) {
		DecimalFormat formatter = new DecimalFormat("###,###");
		List<ProductDTO> products = new ArrayList<>();
		ResultSet rs;
		String bigCategoryName = null;
		String smallCategoryName = null;

		try {
			Connection conn = dataSource.getConnection();
			PreparedStatement stmt;

			// smallCategory가 "view-all"일 때, bigCategory만으로 조회
			if ("view-all".equals(smallCategoryId)) {
				stmt = conn.prepareStatement(
						"SELECT MIN(product_id) AS productId, product_name AS name, price, " +
								"color_count AS colorCount, hit, main_image AS imageUrl, " +
								"COUNT(*) OVER() AS totalCount " +
								"FROM product " +
						"WHERE big_category_id = ? " +
						"GROUP BY product_name, price, color_count, hit, main_image " +
						"ORDER BY MIN(product_id) ASC");
				stmt.setString(1, bigCategoryId);

				// 카테고리명 가져오기
				String getCategoriesSql = 
						"SELECT big_category_name AS big_category " +
						"FROM big_category " +
						"WHERE big_category_id = ?";
				PreparedStatement getCategories = conn.prepareStatement(getCategoriesSql);
				getCategories.setString(1, bigCategoryId);
				ResultSet categories = getCategories.executeQuery();

				if (categories.next()) {
					bigCategoryName = categories.getString("big_category");
					smallCategoryName = "전체 보기";
				}

			} else { // smallCategory와 bigCategory로 조회
				stmt = conn.prepareStatement(
					    "SELECT product_id AS productId, product_name AS name, price, " +
					    "color_count AS colorCount, hit, main_image AS imageUrl, " +
					    "COUNT(*) OVER() AS totalCount " +
					    "FROM product " +
					    "WHERE small_category_id = ? AND big_category_id = ? " +
					    "ORDER BY product_id ASC");
				stmt.setString(1, smallCategoryId);
				stmt.setString(2, bigCategoryId);

				// 카테고리명 가져오기
				System.out.println("small: " + smallCategoryId +",big: " + bigCategoryId);
				String getCategoriesSql = 
						"SELECT sc.small_category_name AS small_category, " +
								"bc.big_category_name AS big_category " +
								"FROM small_category sc " +
								"JOIN big_category bc ON sc.big_category_id = bc.big_category_id " +
								"WHERE sc.small_category_id = ? AND bc.big_category_id = ?";
				PreparedStatement getCategories = conn.prepareStatement(getCategoriesSql);
				getCategories.setString(1, smallCategoryId);
				getCategories.setString(2, bigCategoryId);
				ResultSet categories = getCategories.executeQuery();
				
				if (categories.next()) {
					bigCategoryName = categories.getString("big_category");
					smallCategoryName = categories.getString("small_category");
				} 
			}

			rs = stmt.executeQuery();

			// 상품 데이터 처리
			while (rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setProductId(rs.getLong("productId"));
				product.setBigCategoryName(bigCategoryName);
				product.setSmallCategoryName(smallCategoryName);
				product.setTotalCount(rs.getInt("totalCount"));
				product.setImageUrl(rs.getString("imageUrl"));
				product.setProductName(rs.getString("name"));

				// 가격 처리
				int price = rs.getInt("price");
				if (rs.wasNull()) {
					product.setPrice("일시 품절");
				} else {
					product.setPrice(formatter.format(price) + "원");
				}

				product.setColorCount(rs.getInt("colorCount"));
				product.setHit(rs.getInt("hit"));
				products.add(product);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}

}
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

import lombok.Data;


public class ProductDAO {
	static DataSource dataSource;

	static {
		// MemberDAO 객체가 로드 될 때, dataSource 객체도 로드 되도록
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}

	public ProductDTO getItem(Long productId) {
		ProductDTO item = new ProductDTO();

		try {
			Connection conn = dataSource.getConnection();
			PreparedStatement stmt;
			stmt = conn.prepareStatement(
					"SELECT p.product_name AS name, p.price AS price, i.image_url AS imageUrl " +
							"FROM product p " +
							"LEFT JOIN image i ON p.product_id = i.product_id " +
					"WHERE p.product_id = ?");
			stmt.setLong(1, productId);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				item.setName(rs.getString("name"));
				item.setPrice(rs.getString("price"));
				item.setImageUrl(rs.getString("imageUrl"));
			} else {
				throw new RuntimeException("상품이 없습니다.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return item;
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
						"SELECT p.product_id AS productId, p.product_name AS name, p.price AS price, " +
								"p.color_count AS colorCount, p.hit AS hit, i.image_url AS imageUrl, " +
								"COUNT(*) OVER() AS totalCount " +
								"FROM product p " +
								"LEFT JOIN image i ON p.product_id = i.product_id " +
						"WHERE p.big_category_id = ?");
				stmt.setString(1, bigCategoryId);

				// 카테고리명 가져오기
				String getCategoriesSql = 
						"SELECT bc.big_category_name AS big_category " +
								"FROM big_category bc " +
								"WHERE bc.big_category_id = ?";
				PreparedStatement getCategories = conn.prepareStatement(getCategoriesSql);
				getCategories.setString(1, bigCategoryId);
				ResultSet categories = getCategories.executeQuery();

				if (categories.next()) {
					bigCategoryName = categories.getString("big_category");
					smallCategoryName = "전체 보기";
				}

			} else { // smallCategory와 bigCategory로 조회
				stmt = conn.prepareStatement(
						"SELECT p.product_id AS productId, p.product_name AS name, p.price AS price, " +
								"p.color_count AS colorCount, p.hit AS hit, i.image_url AS imageUrl, " +
								"COUNT(*) OVER() AS totalCount " +
								"FROM product p " +
								"LEFT JOIN image i ON p.product_id = i.product_id " +
						"WHERE p.small_category_id = ? AND p.big_category_id = ?");
				stmt.setString(1, smallCategoryId);
				stmt.setString(2, bigCategoryId);

				// 카테고리명 가져오기
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
				product.setName(rs.getString("name"));

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
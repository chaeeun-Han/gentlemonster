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

import com.gentlemonster.web.dto.StyleDTO;

public class StyleDAO {
	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public List<StyleDTO> getStyleList() {
		List<StyleDTO> styles = new ArrayList<StyleDTO>();
		Connection con = null;

		try {
			con = dataSource.getConnection();
			String sql = "select looks_list_id, product_id, image_url, instagram_id from looks_list";
			PreparedStatement stmt = con.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			if (!rs.next()) {
				throw new SQLException("스타일 목록이 없습니다.");
			}
			while (rs.next()) {
				StyleDTO dto = new StyleDTO();
				dto.setStyleId(rs.getLong("looks_list_id"));
				dto.setProductId(rs.getLong("product_id"));
				dto.setImageUrl(rs.getString("image_url"));
				dto.setInstagramId(rs.getString("instagram_id"));
				styles.add(dto);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(con);
		}
		
		return styles;
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

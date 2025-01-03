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

import com.gentlemonster.web.dto.SearchDTO;
import com.gentlemonster.web.dto.TrendDTO;

public class SearchDAO {
	private DataSource dataSource;
	
	public SearchDAO() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:/comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public List<TrendDTO> getTrend() {
		List<TrendDTO> trendList = new ArrayList<>();
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT id, product_name " + 
					"FROM (" + 
					" SELECT MIN(product_id) as id, product_name, sum(hit) As total_hits" + 
					" FROM product " + 
					" GROUP BY product_name " + 
					" ORDER BY total_hits DESC, product_name " + 
					") " + 
					"WHERE ROWNUM <= 7";
			
	        PreparedStatement stmt = conn.prepareStatement(sql);
	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	        	trendList.add(new TrendDTO(rs.getLong(1), rs.getString(2)));
	        }
	        
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(conn);
		}
		
		return trendList;
	}
	
	public List<SearchDTO> search(String term) {
		List<SearchDTO> searchList = new ArrayList<>();
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "SELECT MIN(product_id), product_name, price, product_count, main_image " +
						"FROM product " +
						"WHERE product_name LIKE '%" + term + "%' " +
						"GROUP BY product_name, price, product_count, main_image " +
						"ORDER BY MIN(product_id)";
						
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				searchList.add(new SearchDTO(rs.getLong(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getString(5)));
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnection(conn);
		}
		
		return searchList;
	}
	
	private void closeConnection(Connection conn) {
		if(conn != null) try {conn.close(); } catch(Exception e) {}
	}
}

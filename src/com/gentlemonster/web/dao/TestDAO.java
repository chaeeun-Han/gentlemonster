package com.gentlemonster.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class TestDAO {
	private DataSource dataSource;
	
	public TestDAO() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:/comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public String test() {
		String str = null;
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			String sql = "select * from big_category";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				str = rs.getString(2);
			}
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return str;
	}
}

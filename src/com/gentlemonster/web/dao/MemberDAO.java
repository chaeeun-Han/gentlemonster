package com.gentlemonster.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.gentlemonster.web.dto.MemberDTO;

public class MemberDAO {
	static DataSource dataSource;
	
	static {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
		} catch(NamingException e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void join(MemberDTO member) {
		Connection con = null;

		try {
			if (!member.getPassword().equals(member.getPasswordCheck())) {
				throw new RuntimeException("비밀번호 확인이 일치하지 않습니다.");
			}
			con = dataSource.getConnection();
			String sql = "insert into customer (user_id, user_pw, birthday, email, address)" + "values (?, ?, ?, ?, ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			//?에 값 세팅
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, member.getPassword());
			pstmt.setTimestamp(3, convertToTimestamp(member.getBirthday()));
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getAddress());
			int rowCount = pstmt.executeUpdate();
			System.out.println(rowCount + "개 행이 변경되었습니다.");
			if (rowCount<=0) {
				throw new SQLException("저장된 행이 없습니다.");
			}
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
	}
	
	public String getPassword(String id) {
		String pw = "";
		Connection con = null;
		
		try {
			con = dataSource.getConnection();
			String sql = "select user_pw from customer where user_id=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				pw = rs.getString("user_pw");
			} else {
				throw new SQLException("아이디가 없습니다.");
			}
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		return pw;
	}
	
	public String getCustomerId(String id, String password) {
		Connection con = null;
		String userid;
		
		try {
			con = dataSource.getConnection();
			String sql = "select customer_id from customer where user_id=? and user_pw=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1, id);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				userid = String.valueOf(rs.getLong("customer_id"));
			} else {
				throw new SQLException("일치하는 회원이 없습니다.");
			}
		} catch(SQLException e) {
			System.out.println(e.getMessage());
			throw new RuntimeException(e);
		} finally {
			closeConnection(con);
		}
		
		return userid;
	}
	
	private void closeConnection(Connection con) {
		if(con!=null) {
			try {
				con.close();
			} catch(Exception e) {
				
			}
		}
	}
	
	private Timestamp convertToTimestamp(String birthday) {

        LocalDate localDate = LocalDate.parse(birthday, DateTimeFormatter.ISO_DATE);
        LocalDateTime localDateTime = localDate.atStartOfDay();
        Timestamp timestamp = Timestamp.valueOf(localDateTime);
        
        return timestamp;
    }
}

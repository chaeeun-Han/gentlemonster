package com.gentlemonster.web.filter;

import java.io.IOException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.gentlemonster.web.dao.CartDAO;

public class CartFilter implements Filter {
    private static DataSource dataSource;

    static {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle");
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 초기화 로직 (필요 시 추가)
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession();

        try {
            // String userId = (String) session.getAttribute("userid"); // 세션에서 사용자 ID 가져오기
            String userId = "1";
            int cartCount = 0;

            if (userId != null) {
                CartDAO cartDAO = new CartDAO(); // CartDAO 생성
                cartCount = cartDAO.getCartCount(userId); // 장바구니 갯수 조회
            }

            request.setAttribute("cart_count", cartCount); // JSP에서 사용할 수 있도록 설정
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("cart_count", 0); // 에러 시 기본값 설정
        }

        chain.doFilter(request, response); // 다음 필터 또는 요청 처리로 전달
    }

    @Override
    public void destroy() {
        // 종료 시 처리 로직 (필요 시 추가)
    }
}

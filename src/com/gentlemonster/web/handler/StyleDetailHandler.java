package com.gentlemonster.web.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.ProductDAO;

@RequestMapping("/styles?id=") // 파라미터를 사용하는 경로
public class StyleDetailHandler implements CommandHandler {

    private ProductDAO productDAO;

    public StyleDetailHandler() {
        productDAO = new ProductDAO();
    }

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {
        
        return "/styles/detail.jsp";
    }
}

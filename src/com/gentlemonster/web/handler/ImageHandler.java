package com.gentlemonster.web.handler;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gentlemonster.web.RequestMapping;
import com.gentlemonster.web.dao.ImageDAO;
import com.gentlemonster.web.dao.ProductDAO;
import com.gentlemonster.web.dto.ImageDTO;
import com.gentlemonster.web.dto.ProductDTO;

@RequestMapping("/shop/item")
public class ImageHandler implements CommandHandler {

    ImageDAO image;

    public ImageHandler() {
        image = new ImageDAO();
    }

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) {

        String id = request.getParameter("id");
        List<ImageDTO> imageList = new ArrayList<>(image.getImage(id));
        request.setAttribute("imageList", imageList);
        ProductDTO productDTO = image.getProduct(id);
        request.setAttribute("product", productDTO);
        List<ImageDTO> mainImage = new ArrayList<>(image.getSimilarProduct(id));
        request.setAttribute("mainImage", mainImage);
        ProductDAO product = new ProductDAO();
        request.setAttribute("hit", product.updateHit(id));
        HttpSession session = request.getSession();
        
        return "/shop/item.jsp";
    }

}

package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {

    private Long productId;
    private String smallCategoryName;
    private String bigCategoryName;
    private String imageUrl;
    private String productName;
    private String price;
    private Integer colorCount;
    private Integer productCount;
    private String discription;
    private String detail;
    private Integer hit;
    private String mainImage;

    private Integer totalCount; // select된 상품 갯수
}
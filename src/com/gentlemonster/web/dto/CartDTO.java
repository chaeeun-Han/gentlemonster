package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {
	private Long cartId;
	private Long customerId;
	private Long productId;
	private Integer productCount;
	
	// 상품 상세 조회를 위해
	private String productName;
	private Integer price;
	private String mainImage;
}
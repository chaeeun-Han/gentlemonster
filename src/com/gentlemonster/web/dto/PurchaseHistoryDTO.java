package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseHistoryDTO {
	private Long productId = null;
	private String productName = null;
	private int productCount;
	private int price; //상품가격 * 개수 저장
	private String imgUrl;
	
	public PurchaseHistoryDTO(String productName, int productCount, int price, String imgUrl) {
		this.productName = productName;
		this.productCount = productCount;
		this.price = price;
		this.imgUrl = imgUrl;
	}

	public PurchaseHistoryDTO(Long productId, int productCount, int price, String imgUrl) {
		this.productId = productId;
		this.productCount = productCount;
		this.price = price;
		this.imgUrl = imgUrl;
	}
}
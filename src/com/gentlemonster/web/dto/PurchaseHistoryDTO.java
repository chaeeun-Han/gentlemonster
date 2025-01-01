package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseHistoryDTO {
	private String productName;
	private int productCount;
	private int price; //상품가격 * 개수 저장
	private String imgUrl;
}

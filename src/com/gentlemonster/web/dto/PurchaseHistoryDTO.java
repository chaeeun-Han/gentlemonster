package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseHistoryDTO {
	private Long productId;
	private int productCount;
	private int price;
	
}

package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SearchDTO {
	private Long productId;
	private String productName;
	private Integer price;
	private Integer productCount;
	private String mainImageUrl;
}

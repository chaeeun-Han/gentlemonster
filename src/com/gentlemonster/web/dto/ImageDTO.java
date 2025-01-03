package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImageDTO {
	private Long imageId;
	private Long productId;
	private String imageUrl;
	
	public ImageDTO(Long productId, String imageUrl){
		this.productId = productId;
		this.imageUrl = imageUrl;
	}
}

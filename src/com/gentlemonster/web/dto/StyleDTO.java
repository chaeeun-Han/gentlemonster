package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StyleDTO {
	private Long styleId;
	private Long productId;
	private String imageUrl;
	private String instagramId;
}

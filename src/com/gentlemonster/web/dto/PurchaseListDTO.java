package com.gentlemonster.web.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseListDTO {

	private Long purchaseId;
	private String purchaseTime;
	private List<PurchaseHistoryDTO> purchaseHistoryDTO;
}

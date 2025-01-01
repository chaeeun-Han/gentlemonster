package com.gentlemonster.web.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseInformationDTO {
	private String purchaseTime;
	private int totalPrice;
}

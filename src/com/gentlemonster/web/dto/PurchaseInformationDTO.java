package com.gentlemonster.web.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseInformationDTO {
	private LocalDateTime purchaseTime;
	private int totalPrice;
	private String receiver;
	private String phoneNumber;
	private String address;
}

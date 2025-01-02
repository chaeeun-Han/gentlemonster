package com.gentlemonster.web.dto;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDTO {
	private Long customerId;
	private String userId;
	private String userPw;
	private Timestamp birthday;
	private String email;
	private String address;
}

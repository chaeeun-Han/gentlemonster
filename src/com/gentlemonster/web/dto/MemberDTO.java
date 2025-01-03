package com.gentlemonster.web.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	private String userid;
	private String password;
	private String passwordCheck;
	private String birthday;
	private String email;
	private String address;
}

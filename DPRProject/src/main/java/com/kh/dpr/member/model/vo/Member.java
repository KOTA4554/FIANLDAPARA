
package com.kh.dpr.member.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private String userId;
	private String userPw;
	private String userName;
	private Date userBirthDate;
	private String userGender;
	private String userAddress;
	private String userPhone;
	private String userEmail;
	private Date userEnrollDate;
	private String userStatus;
	private Date userDropDate;
	
	public Member(String userId, String userPw) {
		this.userId = userId;
		this.userPw = userPw;
	}
}


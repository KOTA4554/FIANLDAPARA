package com.kh.dpr.seller.model.vo;

import java.io.Serializable;
import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Component
@NoArgsConstructor
@AllArgsConstructor
@Data
@ToString
public class Seller implements Serializable {

	private static final long serialVersionUID = 1L;

	private String sellerId;
	private String sellerPw;
	private String sellerNo;
	private String sellerCompany;
	private String sellerName;
	private String sellerAddress;
	private String sellerPhone;
	private Date sellerEnrollDate;
	private String sellerStatus;
	private Date sellerDropDate;

	
	public Seller(String sellerId, String sellerPw) {
		super();
		this.sellerId = sellerId;
		this.sellerPw = sellerPw;
	}
	
}

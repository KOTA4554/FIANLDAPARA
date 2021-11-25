package com.kh.dpr.cart.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import com.kh.dpr.member.model.vo.Member;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Component
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cart {

	
	private String userId;
	private int productNo;
	private int cartAmount;
	private String sizeName;


public Cart(String userId,int productNo){
	super();
	this.userId=userId;
	this.productNo=productNo;
}
	
	
	
}

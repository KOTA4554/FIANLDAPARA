package com.kh.dpr.seller.model.vo;

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
public class Calculate {
	
	private static final long serialVersionUID = 42521L;
	
	private int totalGross;
	private int cancleGross;
	private int realGross;
	private int commission;
	private int discount;
	
	private String month;
	private int totalMonthGross;
	private int cancleMonthGross;
	
}

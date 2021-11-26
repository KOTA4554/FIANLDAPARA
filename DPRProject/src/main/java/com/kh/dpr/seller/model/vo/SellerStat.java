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
public class SellerStat implements Serializable {

	private static final long serialVersionUID = 42511L;
	
	private int totalCancle;
	private int totalRefund;
	private int totalSwap;
	private int unsolvedCancle;
	private int unsolvedRefund;
	private int unsolvedSwap;
	
	private int sellProduct;
	private int impendProduct;
	private int endProduct;
	
	private int waitDel;
	private int completeDel;
	
	private int reviewCnt;
	private int orderCnt;
	
	private int qna;
	private int unsolvedQna;
	
}

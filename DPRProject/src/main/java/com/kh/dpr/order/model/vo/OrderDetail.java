package com.kh.dpr.order.model.vo;

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
public class OrderDetail implements Serializable{
	
	private int detailNo;
	private int orderNo;
	private int productNo;
	private int deleveryNo;
	private int processCode;
	private int paymentCode;
	private int detailAmount;
	private int detailPrice;
	private Date payDate;
	private String detailSize;
}

package com.kh.dpr.order.model.vo;

import java.sql.Date;
import java.util.List;

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
public class Delivery {
	
	private int orderNo;
	private String userId;
	private Date orderDate;
	private String orderAddress;
	private String orderReceiver;
	private String orderRequest;
	private String orderPhone;
	private int detailNo;
	
	private int productNo;
	private int deliveryNo;
	private int processCode;
	private int paymentCode;
	private int detailAmount;
	private int detailPrice;
	private Date payDate;
	private String detailSize;
	
	private int deliveryCode;
	private String productName;
	
	private List<Delivery> deliveryList;
	
	public List<Delivery> getDeliveryList() {
		return deliveryList;
	}
	
	public void setDeliveryList(List<Delivery> deliveryList) {
		this.deliveryList = deliveryList; 
	}
}

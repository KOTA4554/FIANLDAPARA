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
public class Order implements Serializable{
	private int orderNo;
	private String userId;
	private Date orderDate;
	private String[] orderAddress;
	private String orderReceiver;
	private String orderRequest;
	private String orderPhone;
}

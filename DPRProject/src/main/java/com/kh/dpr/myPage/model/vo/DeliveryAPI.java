package com.kh.dpr.myPage.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import com.kh.dpr.product.model.vo.Product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Component
@NoArgsConstructor
@AllArgsConstructor
@Data
@ToString
public class DeliveryAPI {

	private long deliveryNo;
	private int deliveryCode;
	private String deliveryCode2;

}

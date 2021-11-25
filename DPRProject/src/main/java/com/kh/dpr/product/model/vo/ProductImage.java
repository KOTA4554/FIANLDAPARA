package com.kh.dpr.product.model.vo;

import java.io.Serializable;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Component
@ToString
public class ProductImage implements Serializable {
	
	private static final long serialVersionUID = 123L;
	
	private int productImageNo;
	private int productNo;
	private int imageCategoryNo;
	private String productOldImage;
	private String productNewImage;
	
}

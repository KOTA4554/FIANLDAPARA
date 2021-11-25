package com.kh.dpr.product.model.vo;


import java.io.Serializable;
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
@ToString
@Data
public class Product implements Serializable {
	
	private static final long serialVersionUID = 11L;
	
	private int productNo;
	private int optionNo;
    private int categoryNo2;
    private int sizeId;
    private String sellerId;
    private int productId;
    private String productName;
    private int productPrice;
    private int productAmount;
    private String productStatus;
    private String optionStatus;
    private String productInfo;
    private Date productStartdate;
    private Date productEnddate;
    private String productContent;
    private int productCount;
    private String productBrand;
    private String productOldImage;
	private String productNewImage;
    private String mainImage;
    private int optionCount;
    private String categoryName;
    private int categoryNo; // 대분류 카테고리 번호
    private String sizeName; // 사이즈 텍스트 명



}

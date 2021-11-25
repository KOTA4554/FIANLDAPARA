package com.kh.dpr.claim.model.vo;

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
public class Claim {

	

		private int claimNo;
	    private int detailNo;
	    private int claimCode;
	    private String claimContent;
	    private Date claimDate;
	    private Date CompleteClaim;
	   
	
}

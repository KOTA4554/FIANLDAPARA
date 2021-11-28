package com.kh.dpr.qnaComment.model.vo;

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
public class qnaComment implements Serializable {
	
	private int cNo;
	private int qNo;
	private String sellerId;
	private String cContent;
	private Date cDate;
	private String cStatus;
	
	
	
	
	
	public qnaComment (int qNo, String sellerId, String cContent) {
		super();
		this.qNo=qNo;
		this.sellerId=sellerId;
		this.cContent=cContent;
		
	};
	
	
	
	
	

}

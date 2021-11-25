package com.kh.dpr.qna.model.vo;

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
public class QnA implements Serializable{

	private int qNo;
	private String userId;
	private int productNo;
	private String qTitle;
	private String qContent;
	private Date qdate;
	private String qStatus;
	
	
	public QnA (String userId, String qTitle, String qContent, int productNo) {
		super();
		this.userId=userId;
		this.qTitle=qTitle;
		this.qContent=qContent;
		this.productNo=productNo;
		
		
	};
}

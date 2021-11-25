package com.kh.dpr.review.model.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Component
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class Review {

	private int reviewNo;
	private String userId;
	private int detailNo;
	private String reviewContent;
	private int reviewScore;
	private Date reviewDate;
	private String reviewStatus;
	private String reviewOldImage;
	private String reviewNewImage;
	
}

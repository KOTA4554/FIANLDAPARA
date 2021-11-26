package com.kh.dpr.seller.model.vo;

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
public class Gross implements Serializable {

	private static final long serialVersionUID = 42421L;
	
	private int timeHours;
	private int gross;
		
}

package com.kh.dpr.statistic.model.vo;

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
public class MonthRevenue {
	
	private int month;
	private int revenue;
	
}

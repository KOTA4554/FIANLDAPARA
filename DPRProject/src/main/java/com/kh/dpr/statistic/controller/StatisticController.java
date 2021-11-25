package com.kh.dpr.statistic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StatisticController {

	
	@RequestMapping("/statistic/statisticPage.do")
	public String statisticPage() {
		
		
		return "statistic/statisticPage";
	}
	
}

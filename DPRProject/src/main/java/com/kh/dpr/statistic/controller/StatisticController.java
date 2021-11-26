package com.kh.dpr.statistic.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;
import com.kh.dpr.statistic.model.service.StatisticService;
import com.kh.dpr.statistic.model.vo.MonthRevenue;

@Controller
public class StatisticController {
	
	@Autowired
	StatisticService statisticService;

	
	@RequestMapping("/statistic/statisticPage.do")
	public String statisticPage(HttpServletRequest request, Model model) {
		// sellerId
		HttpSession session = request.getSession(false);
		
		Seller seller = (Seller)session.getAttribute("seller");
		
		String sellerId = seller.getSellerId();
		
		
		// 판매자가 올린 상품 리스트
		List<Product> prodList = statisticService.selectProductList(sellerId);

		// 월 매출액 가져오기
		List<MonthRevenue> monthRevenue = statisticService.selectMonthRevenue(sellerId);
		
		//상품별 매출액, 판매량
		List<Integer> productRevenueList = new ArrayList<Integer>();
		List<Integer> productSaleAmount = new ArrayList<Integer>();
		List<String> productNameList = new ArrayList<String>();
		
		for(int i = 0; i < prodList.size(); i++) {
			
			int productNo = prodList.get(i).getProductNo();
			int productPrice = prodList.get(i).getProductPrice();
			String productName = prodList.get(i).getProductName(); 
			
			// 주문량 찾기
			int orderCount = statisticService.selectOrderCount(productNo);
			
			// 상품별 매출액
			int productRevenue = productPrice * orderCount;
			
			productNameList.add(productName);
			productSaleAmount.add(orderCount);
			productRevenueList.add(productRevenue);
			
		}
		
		// 평점 top4 상품
		List<Product> top4List = statisticService.selectTop4(sellerId);
		
		// 구매자 성비
		int userMan = statisticService.selectUserMan(sellerId);
		int userWoman = statisticService.selectUserWoman(sellerId);
		
		// 월별매출액 전달
		model.addAttribute("monthRevenue", monthRevenue);
		
		// 상품별 총 매출액, 판매량, 상품명 전달
		model.addAttribute("productNameList", productNameList);
		model.addAttribute("productSaleAmount", productSaleAmount);
		model.addAttribute("productRevenueList", productRevenueList);
		
		// 평점 top4 상품 전달
		model.addAttribute("top4List", top4List);
		
		// 구매자 성비 전달
		model.addAttribute("userMan", userMan);
		model.addAttribute("userWoman", userWoman);
		
		return "statistic/statisticPage";
	}
	
}

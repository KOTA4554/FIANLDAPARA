package com.kh.dpr.prod.controller;


import java.util.ArrayList;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.dpr.prod.model.service.ProdService;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;

@Controller
public class ProdController {
	
	@Inject
	ProdService ProdService;

	
	
	
	@RequestMapping("/prod_detail.do")
	public String detail(@RequestParam int prodNo, Model model) {
		
		System.out.println("상세보기 접근 확인" + prodNo);
		
		Product prod = ProdService.selectProd(prodNo);
		Seller seller2 = ProdService.selectSeller(prodNo);
		List<String> image = ProdService.loadImage(prodNo);
		List<Review> review = ProdService.review(prodNo);
		int rCount = review.size();
		List<Product> random = ProdService.random();
		List<String> rImage = new ArrayList<String>();
		List<QnA> qna = ProdService.qna(prodNo);

		for (int i = 0; i < random.size() ; i ++) {
			
			
			int randomNo = random.get(i).getProductNo();
			String randomImage = ProdService.randomImage(randomNo);
			
			rImage.add(randomImage);
		}
	
		System.out.println(qna);
	
			
		model.addAttribute("qna", qna);
	    model.addAttribute("rImg", rImage);	
		model.addAttribute("random", random);
		model.addAttribute("prod", prod);
		model.addAttribute("seller2", seller2);
		model.addAttribute("image", image);
		model.addAttribute("review", review);
		model.addAttribute("rCount", rCount);
	
		
		return "prod/prod_detail";
	}
	
	
	@RequestMapping("/qnaInsert.do")
	public String qna(@RequestParam String userId, String qTitle, String qContent, int productNo, Model model) {
	
		QnA q = new QnA(userId, qTitle, qContent, productNo);
		
	
		int result = ProdService.qnaInsert(q);
		
		String loc = "/prod_detail.do?prodNo="+productNo;
		String msg = "";
		if(result > 0) {
			
			msg = "문의가 등록되었습니다.";
		} else {
			
			msg = "문의 등록에 실패하였습니다.";
		}
	
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	
	
	}
	
	

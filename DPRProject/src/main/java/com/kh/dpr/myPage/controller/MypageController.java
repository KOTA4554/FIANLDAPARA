package com.kh.dpr.myPage.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.dpr.member.model.vo.Member;
import com.kh.dpr.myPage.model.service.MyPageService;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

@Controller
public class MypageController {

	@Autowired
	MyPageService myPageService;
		
	@RequestMapping("/myPage/myPage.do")
	public String myPage(HttpServletRequest request, Model model) {
		
		// 세션 아이디 가져오기
		HttpSession session = request.getSession(false);
		
		Member member = (Member)session.getAttribute("member");
		
		String userId = member.getUserId();
		
		// userId 일치하는 order
		List<Order> orderList = myPageService.selectOrderList(userId);
		
		// orderNo 일치하는 orderDetail
		List<OrderDetail> orderDetailList = myPageService.selectOrderDetailList(userId); 
		
		//seller 조회
		List<Seller> sellerList = new ArrayList<Seller>();
		
		
		for(int i = 0; i < orderDetailList.size(); i++) {
			
			// detailNo
			int detailNo = orderDetailList.get(i).getDetailNo();
			
			Seller seller = myPageService.selectSeller(detailNo);
			
			sellerList.add(seller);
		}
		
		// productno 일치하는 product
		List<Product> prodList = new ArrayList<Product>();
		
		List<String> productImgList = new ArrayList<String>();
		
		for(int i = 0; i < orderDetailList.size(); i++) {
			
			// productNo
			int productNo = orderDetailList.get(i).getProductNo();
			
			Product prod = myPageService.selectProd(productNo);
			
			prodList.add(prod);
			
			// 대표 이미지 불러오기
			String productImg = myPageService.selectImg(productNo);
			
			productImgList.add(productImg);
		}
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("orderDetailList", orderDetailList);
		model.addAttribute("sellerList", sellerList);
		model.addAttribute("prodList", prodList);
		model.addAttribute("productImgList", productImgList);
		
		return "myPage/myPage";
	}
	
	@RequestMapping("/myPage/complete.do")
	public String complete(@RequestParam int detailNo, Model model) {
		
		int result = myPageService.updateComplete(detailNo);
		
		String loc = "/myPage/myPage.do";
		String msg = "";
		if(result > 0) {
			
			msg = "구매 확정 하였습니다.";
		} else {
			
			msg = "구매 확정에 실패했습니다.";
		}
	
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
}

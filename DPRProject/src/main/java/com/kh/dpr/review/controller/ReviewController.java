package com.kh.dpr.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.dpr.order.model.service.OrderService;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.review.model.service.ReviewService;
import com.kh.dpr.review.model.vo.Review;



@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/reviewForm.do")
	public String reviewForm(@RequestParam int detailNo, Model model) {
		
		
		Product product = reviewService.selectProduct(detailNo); 
		
		int productNo = product.getProductNo();
		
		String sizeName = reviewService.selectSizeName(detailNo);
		
		String productImg = reviewService.selectImg(productNo);
		
		model.addAttribute("detailNo", detailNo);
		model.addAttribute("product", product);
		model.addAttribute("sizeName", sizeName);
		model.addAttribute("productImg", productImg);
		
		return "myPage/reviewForm";
	}
	
	@RequestMapping("/reviewInsert.do")
	public String reviewInsert(Review review, Model model, HttpServletRequest request,
			   				   @RequestParam(value="upFile", required=false)MultipartFile upFile) {
		
		System.out.println(review);
		
		// 파일저장경로 설정
		String savePath = request.getServletContext().getRealPath("/resources/reviewImg");
		
		// 파일 이름 변경
		if(upFile.isEmpty() == false) {
			
			String oldName = upFile.getOriginalFilename();
			String changeName = fileNameChanger(oldName);
			
			try {
				upFile.transferTo(new File(savePath + "/" + changeName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			review.setReviewOldImage(oldName);
			review.setReviewNewImage(changeName);
		}
		
		// 리뷰 DB등록
		int result = reviewService.insertReview(review);
		
		String loc = "/myPage/myPage.do";
		String msg = "";
		
		if(result > 0) {
			msg = "리뷰 등록 완료!";
		} else {
			msg = "리뷰 등록 실패!";
		}
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	// 단순 파일 이름 변경 메소드
	public String fileNameChanger(String oldName) {

		String ext = oldName.substring(oldName.lastIndexOf(".") + 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmss");
		int rnd = (int)(Math.random() * 1000);
		
		return sdf.format(new Date(System.currentTimeMillis())) + "_" + rnd + "." + ext; 
			
	}
	
}

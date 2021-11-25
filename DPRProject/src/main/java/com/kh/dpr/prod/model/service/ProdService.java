package com.kh.dpr.prod.model.service;

import java.util.List;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;

public interface ProdService {

	Product selectProd(int prodNo);
	
	Seller selectSeller(int prodNo);
	
	List<String> loadImage(int prodNo);
	
	List<Review> review(int prodNo);
	
	List<Product> random();
	
	String randomImage(int randomNo);
	
	int qnaInsert(QnA q);
	
	List<QnA> qna(int prodNo);

}
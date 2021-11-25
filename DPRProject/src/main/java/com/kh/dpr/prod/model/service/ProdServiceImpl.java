package com.kh.dpr.prod.model.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.dpr.prod.model.dao.ProdDAO;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;

@Service
public class ProdServiceImpl implements ProdService  {
	
	@Inject
	ProdDAO ProdDAO;

	@Override
	public Product selectProd(int prodNo) {
		
		int result = ProdDAO.viewcount(prodNo);
		
		return ProdDAO.selectProd(prodNo);
		
	}

	@Override
	public Seller selectSeller(int prodNo) {
	
	return ProdDAO.selectSeller(prodNo);
}
	
	@Override
	public List<String> loadImage(int prodNo) {
		
		return ProdDAO.loadImage(prodNo);
	}

	@Override
	public List<Review> review(int prodNo) {
		
		return ProdDAO.review(prodNo);
	}

	@Override
	public List<Product> random() {
		
		return ProdDAO.random();
	}

	@Override
	public String randomImage(int randomNo) {
		
		return ProdDAO.randomImage(randomNo);
	}

	@Override
	public int qnaInsert(QnA q) {
		
		return ProdDAO.qnaInsert(q);
	}

	@Override
	public List<QnA> qna(int prodNo) {
		
		return ProdDAO.qna(prodNo);
	}
}
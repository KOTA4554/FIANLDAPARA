package com.kh.dpr.review.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.review.model.dao.ReviewDAO;
import com.kh.dpr.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDAO reviewDAO;
	
	@Override
	public Product selectProduct(int detailNo) {
		
		return reviewDAO.selectProduct(detailNo);
	}

	@Override
	public String selectSizeName(int detailNo) {
		
		return reviewDAO.selectSizeName(detailNo);
	}

	@Override
	public int insertReview(Review review) {
		
		return reviewDAO.insertReview(review);
	}

	@Override
	public String selectImg(int productNo) {
		
		return reviewDAO.selectImg(productNo);
	}

}

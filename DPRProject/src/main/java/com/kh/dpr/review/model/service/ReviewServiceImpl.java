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

	@Override
	public int selectProductNo(int detailNo) {
		
		return reviewDAO.selectProductNo(detailNo);
	}

	@Override
	public int updateScore(int productNo) {
		
		return reviewDAO.updateScore(productNo);
	}

	@Override
	public Review selectReivew(int reviewNo) {
		
		return reviewDAO.selectReview(reviewNo);
	}

	@Override
	public int deleteReview(int reviewNo) {
		
		return reviewDAO.deleteReview(reviewNo);
	}

	@Override
	public int updateReview(Review review) {
		
		return reviewDAO.updateReview(review);
	}

}

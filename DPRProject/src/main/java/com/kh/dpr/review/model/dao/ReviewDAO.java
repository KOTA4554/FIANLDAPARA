package com.kh.dpr.review.model.dao;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.review.model.vo.Review;

public interface ReviewDAO {
	
	Product selectProduct(int detailNo);
	
	String selectSizeName(int detailNo);
	
	int insertReview(Review review);

	String selectImg(int productNo);
}

package com.kh.dpr.myPage.model.dao;

import java.util.List;

import com.kh.dpr.myPage.model.vo.DeliveryAPI;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;

public interface MyPageDAO {
	
	
	List<Order> selectOrderList(String userId);
	
	List<OrderDetail> selectOrderDetailList(String userId);
	
	Seller selectSeller(int detailNo);
	
	Product selectProd(int productNo);
	
	String selectImg(int productNo);

	int updateComplete(int detailNo);

	DeliveryAPI selectDelivery(int detailNo);

	List<Review> selectReviewList(String userId, int cPage, int numPerPage);

	int selectTotalReview(String userId);
	
	List<QnA> selectQnAList(String userId, int cPage, int numPerPage);

	int selectTotalQnA(String userId);

	Product selectRproduct(int reviewNo);

	Product selectQproduct(int qNo);
	
}

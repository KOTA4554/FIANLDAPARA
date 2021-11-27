package com.kh.dpr.myPage.model.service;

import java.util.List;

import com.kh.dpr.claim.model.vo.Claim;
import com.kh.dpr.myPage.model.vo.DeliveryAPI;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

public interface MyPageService {
	
	List<Order> selectOrderList(String userId);
	
	List<OrderDetail> selectOrderDetailList(String userId);
	
	Seller selectSeller(int detailNo);
	
	Product selectProd(int productNo);
	
	String selectImg(int productNo);

	int updateComplete(int detailNo);

	DeliveryAPI selectDelivery(int detailNo);

	Claim selectClaimList(int detailNo);
	
}

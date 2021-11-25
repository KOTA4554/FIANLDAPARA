package com.kh.dpr.myPage.model.dao;

import java.util.List;

import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

public interface MyPageDAO {
	
	
	List<Order> selectOrderList(String userId);
	
	List<OrderDetail> selectOrderDetailList(String userId);
	
	Seller selectSeller(int detailNo);
	
	Product selectProd(int productNo);
	
	String selectImg(int productNo);

	int updateComplete(int detailNo);
	
}

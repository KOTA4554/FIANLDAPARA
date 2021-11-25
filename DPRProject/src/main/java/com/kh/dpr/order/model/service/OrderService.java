package com.kh.dpr.order.model.service;

import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;

public interface OrderService {
	
	int orderInsert(Order order);
	
	Order orderSelectOne();
	
	int orderDetailInsert(OrderDetail orderDetail); 
	
	Product selectProduct(int prodcutNo);

	String selectImg(int productNo);
	
}

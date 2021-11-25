package com.kh.dpr.order.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.order.model.dao.OrderDAO;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDAO orderDAO;
	
	@Override
	public int orderInsert(Order order) {
		
		return orderDAO.orderInsert(order);
	}

	@Override
	public Order orderSelectOne() {
		
		return orderDAO.orderSelectOne();
	}

	@Override
	public int orderDetailInsert(OrderDetail orderDetail) {
		
		return orderDAO.orderDetailInsert(orderDetail);
	}

	@Override
	public Product selectProduct(int prodcutNo) {
		
		return orderDAO.selectProduct(prodcutNo);
	}

	@Override
	public String selectImg(int productNo) {
		
		return orderDAO.selectImg(productNo);
	}

}

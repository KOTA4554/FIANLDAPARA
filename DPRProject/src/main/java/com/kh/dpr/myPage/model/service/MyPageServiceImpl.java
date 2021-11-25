package com.kh.dpr.myPage.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.myPage.model.dao.MyPageDAO;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.seller.model.vo.Seller;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	MyPageDAO myPageDAO;
	
	@Override
	public List<Order> selectOrderList(String userId) {
		
		return myPageDAO.selectOrderList(userId);
	}

	@Override
	public List<OrderDetail> selectOrderDetailList(String userId) {
		
		
		return myPageDAO.selectOrderDetailList(userId);
	}

	@Override
	public Seller selectSeller(int detailNo) {
		// TODO Auto-generated method stub
		return myPageDAO.selectSeller(detailNo);
	}

	@Override
	public Product selectProd(int productNo) {
		
		return myPageDAO.selectProd(productNo);
	}

	@Override
	public String selectImg(int productNo) {
		
		return myPageDAO.selectImg(productNo);
	}

	@Override
	public int updateComplete(int detailNo) {
		
		return myPageDAO.updateComplete(detailNo);
	}

}

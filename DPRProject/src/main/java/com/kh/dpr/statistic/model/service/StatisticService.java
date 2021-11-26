package com.kh.dpr.statistic.model.service;

import java.util.List;

import com.kh.dpr.product.model.vo.Product;

public interface StatisticService {
	
	List<Product> selectProductList(String sellerId);

	int selectOrderCount(int productNo);

	List<Product> selectTop4(String sellerId);
	
}

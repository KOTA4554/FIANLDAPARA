package com.kh.dpr.statistic.model.dao;

import java.util.List;

import com.kh.dpr.product.model.vo.Product;

public interface StatisticDAO {

	List<Product> selectProductList(String sellerId);

	int selectOrderCount(int productNo);

	List<Product> selectTop4(String sellerId);

	int selectUserMan(String sellerId);
	
	int selectUserWoman(String sellerId);
}

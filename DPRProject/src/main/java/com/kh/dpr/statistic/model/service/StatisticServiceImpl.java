package com.kh.dpr.statistic.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.statistic.model.dao.StatisticDAO;

@Service
public class StatisticServiceImpl implements StatisticService {

	@Autowired
	StatisticDAO statisticDAO;
	
	@Override
	public List<Product> selectProductList(String sellerId) {
		
		return statisticDAO.selectProductList(sellerId);
	}

	@Override
	public int selectOrderCount(int productNo) {
		
		return statisticDAO.selectOrderCount(productNo);
	}

	@Override
	public List<Product> selectTop4(String sellerId) {
		
		return statisticDAO.selectTop4(sellerId);
	}

	@Override
	public int selectUserMan(String sellerId) {
		
		return statisticDAO.selectUserMan(sellerId);
	}

	@Override
	public int selectUserWoman(String sellerId) {
		
		return statisticDAO.selectUserWoman(sellerId);
	}

}

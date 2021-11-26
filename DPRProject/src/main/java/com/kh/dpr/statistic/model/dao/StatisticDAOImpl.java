package com.kh.dpr.statistic.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.product.model.vo.Product;

@Repository
public class StatisticDAOImpl implements StatisticDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Product> selectProductList(String sellerId) {
		
		return sqlSession.selectList("statisticSQL.selectProductList", sellerId);
	}

	@Override
	public int selectOrderCount(int productNo) {
		
		return sqlSession.selectOne("statisticSQL.selectOrderCount", productNo);
	}

	@Override
	public List<Product> selectTop4(String sellerId) {
		
		return sqlSession.selectList("statisticSQL.selectTop4", sellerId);
	}

}

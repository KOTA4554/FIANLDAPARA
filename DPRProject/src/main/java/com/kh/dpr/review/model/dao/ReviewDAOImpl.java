package com.kh.dpr.review.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.review.model.vo.Review;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public Product selectProduct(int detailNo) {
		
		return sqlSession.selectOne("reviewSQL.selectProduct", detailNo);
	}

	@Override
	public String selectSizeName(int detailNo) {
		
		return sqlSession.selectOne("reviewSQL.selectSizeName", detailNo);
	}

	@Override
	public int insertReview(Review review) {
		
		return sqlSession.insert("reviewSQL.insertReview", review);
	}

	@Override
	public String selectImg(int productNo) {
	
		return sqlSession.selectOne("reviewSQL.selectImg", productNo);
	}

}

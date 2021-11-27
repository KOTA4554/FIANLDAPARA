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

	@Override
	public int selectProductNo(int detailNo) {
		
		return sqlSession.selectOne("reviewSQL.selectProductNo", detailNo);
	}

	@Override
	public int updateScore(int productNo) {
		
		return sqlSession.update("reviewSQL.updateScore", productNo);
	}

	@Override
	public Review selectReview(int reviewNo) {
		
		return sqlSession.selectOne("reviewSQL.selectReview",reviewNo);
	}

	@Override
	public int deleteReview(int reviewNo) {
		
		return sqlSession.delete("reviewSQL.deleteReview", reviewNo);
	}

	@Override
	public int updateReview(Review review) {
		
		return sqlSession.update("reviewSQL.updateReview", review);
	}

}

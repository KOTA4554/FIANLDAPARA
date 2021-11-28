package com.kh.dpr.myPage.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.claim.model.vo.Claim;
import com.kh.dpr.myPage.model.vo.DeliveryAPI;
import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
import com.kh.dpr.qna.model.vo.QnA;
import com.kh.dpr.review.model.vo.Review;
import com.kh.dpr.seller.model.vo.Seller;

@Repository
public class MyPageDAOImpl implements MyPageDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Order> selectOrderList(String userId) {
		
		return sqlSession.selectList("myPageSQL.selectOrderList", userId);
	}

	@Override
	public List<OrderDetail> selectOrderDetailList(String userId) {

		return sqlSession.selectList("myPageSQL.selectOrderDetailList", userId);
	}

	@Override
	public Seller selectSeller(int detailNo) {
		
		return sqlSession.selectOne("myPageSQL.selectSeller", detailNo);
	}

	@Override
	public Product selectProd(int productNo) {
		
		return sqlSession.selectOne("myPageSQL.selectProd", productNo);
	}

	@Override
	public String selectImg(int productNo) {
		
		return sqlSession.selectOne("myPageSQL.selectImg", productNo);
	}

	@Override
	public int updateComplete(int detailNo) {
		
		return sqlSession.update("myPageSQL.updateComplete", detailNo);
	}


	@Override
	public DeliveryAPI selectDelivery(int detailNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageSQL.selectDelivery",detailNo);
	}

	@Override
	public Claim selectClaimList(int detailNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("myPageSQL.selectClaimList", detailNo);
	}

	@Override
	public List<Review> selectReviewList(String userId, int cPage, int numPerPage) {
		RowBounds rows = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("myPageSQL.selectReviewList", userId, rows);
	}

	@Override
	public int selectTotalReview(String userId) {
		
		return sqlSession.selectOne("myPageSQL.selectTotalReview", userId);
	}

	@Override
	public List<QnA> selectQnAList(String userId, int cPage, int numPerPage) {
		RowBounds rows = new RowBounds((cPage-1)*numPerPage, numPerPage);
		return sqlSession.selectList("myPageSQL.selectQnAList", userId, rows);
	}

	@Override
	public int selectTotalQnA(String userId) {
		
		return sqlSession.selectOne("myPageSQL.selectTotalQnA", userId);
	}

	@Override
	public Product selectRproduct(int reviewNo) {
		return sqlSession.selectOne("myPageSQL.selectRproduct", reviewNo);
	}

	@Override
	public Product selectQproduct(int qNo) {
		return sqlSession.selectOne("myPageSQL.selectRproduct", qNo);

	}

}

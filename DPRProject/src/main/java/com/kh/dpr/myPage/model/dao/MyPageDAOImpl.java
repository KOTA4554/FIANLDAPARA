package com.kh.dpr.myPage.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.dpr.order.model.vo.Order;
import com.kh.dpr.order.model.vo.OrderDetail;
import com.kh.dpr.product.model.vo.Product;
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

}

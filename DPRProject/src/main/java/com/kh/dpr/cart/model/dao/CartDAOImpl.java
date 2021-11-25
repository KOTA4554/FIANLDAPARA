package com.kh.dpr.cart.model.dao;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.dpr.cart.model.vo.Cart;
import com.kh.dpr.product.model.vo.Product;


@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSessionTemplate sqlSession;
	
	@Override
	public int addCart(Cart c) {

		return sqlSession.insert("cart.addCart", c);
	}


	@Override
	public List<Cart> cartList(String userId){
		
		
		
		return sqlSession.selectList("cart.cartList",userId);
		
	};
	
	@Override
	public Product selectProd(int prodNo) {

		return sqlSession.selectOne("prod.selectProd", prodNo);
	}
	
	@Override
	public int changeAmountP(Cart c) {	
		
	return sqlSession.update("cart.changeAmountP",c);
	
	}
	
	@Override
	public int changeAmountM(Cart c) {	
		
	return sqlSession.update("cart.changeAmountM",c);
	
	}


	@Override
	public String loadImage(int productNo) {
		
		return sqlSession.selectOne("cart.loadImage", productNo);
	}
	
	
}
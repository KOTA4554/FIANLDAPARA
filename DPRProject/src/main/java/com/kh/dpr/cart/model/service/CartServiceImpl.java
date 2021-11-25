package com.kh.dpr.cart.model.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kh.dpr.cart.model.dao.CartDAO;
import com.kh.dpr.cart.model.vo.Cart;
import com.kh.dpr.prod.model.dao.ProdDAO;
import com.kh.dpr.product.model.vo.Product;

@Service
public class CartServiceImpl implements CartService {
	
	@Inject
	CartDAO CartDAO;
	

	@Override
	public int addCart(Cart c) {
		
		return CartDAO.addCart(c);
	}
	
	@Override
	public List<Cart> cartList(String userId){
		
		
		
		return CartDAO.cartList(userId);
		
	};
	
	@Override
	public Product selectProd(int prodNo) {
				
		return CartDAO.selectProd(prodNo);
		
	}
	
	@Override
	public int changeAmountP(Cart c) {
		
		return CartDAO.changeAmountP(c);
		
	}
	
	@Override
	public int changeAmountM(Cart c) {
		
		return CartDAO.changeAmountM(c);
		
	}

	@Override
	public String loadImage(int productNo) {
		
		return CartDAO.loadImage(productNo);
	}
	

}
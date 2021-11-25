package com.kh.dpr.cart.model.service;

import java.util.List;

import com.kh.dpr.cart.model.vo.Cart;
import com.kh.dpr.product.model.vo.Product;

public interface CartService {

	int addCart(Cart c);
	
	List<Cart> cartList(String userId);
	
	Product selectProd(int prodNo);

	int changeAmountP(Cart c);
	
	int changeAmountM(Cart c);
	
	String loadImage(int productNo);
	
	
}
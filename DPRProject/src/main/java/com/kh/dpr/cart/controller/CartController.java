package com.kh.dpr.cart.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.dpr.cart.model.service.CartService;
import com.kh.dpr.cart.model.vo.Cart;
import com.kh.dpr.member.model.vo.Member;
import com.kh.dpr.product.model.vo.Product;

@Controller
public class CartController {
	
	@Inject
	CartService CartService;

	
	@RequestMapping("/prod/cart.do")
	public String cart(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession(false);

        Member member = (Member)session.getAttribute("member");

        String userId = member.getUserId();

		
		//카트정보조회
		List<Cart> c = CartService.cartList(userId);
		//조회된 카트내의 품목 갯수
		int count =  c.size();
		//조회된 카트 배열 각각에 해당하는 product_detail정보
		List<Product> cartProductList = new ArrayList<Product>(); 
		List<String> cartImageList = new ArrayList<String>();
				
		
		for(int i = 0; i < count; i++) {

	            int productNo = c.get(i).getProductNo();

	            Product prod = CartService.selectProd(productNo);
                String img = CartService.loadImage(productNo);
	            
	            cartProductList.add(prod);
	            cartImageList.add(img);
	        }
		
	

		int totalPrice = 0;
		
		
		for(int i = 0; i < count; i++) {
			int amount = c.get(i).getCartAmount();
			int price = cartProductList.get(i).getProductPrice();
			
			totalPrice = totalPrice + (amount*price);
			
			
			
		}
		
		
		
		System.out.println(cartImageList);
		
		
		model.addAttribute("image", cartImageList);
		model.addAttribute("cart", c);
        model.addAttribute("count", count);
        model.addAttribute("cartProduct", cartProductList);
        model.addAttribute("total", totalPrice);
		
	return "prod/cart";
		
	}
	
	
	@RequestMapping("/addcart.do")
	public void addCart(@RequestParam String userId, int productNo, int cartAmount, String sizeName, HttpServletResponse response) throws IOException {
			
		Cart c = new Cart(userId,productNo,cartAmount,sizeName);
		
		int result = CartService.addCart(c);
				
		System.out.println(result);
		
		response.getWriter().print(result);
		
	
		
		
	}


	@RequestMapping("/changeAmountP.do")
	public void changeAmount(@RequestParam String userId, int productNo, HttpServletResponse response) throws IOException {
	
		
		Cart c = new Cart(userId,productNo);
		
		System.out.println("장바구니 숫자변경 접근 확인" + c);
		
		
		
		int result = CartService.changeAmountP(c);
		
		response.getWriter().print(result);
	
		
	}
	
	@RequestMapping("/changeAmountM.do")
	public void changeAmount2(@RequestParam String userId, int productNo, HttpServletResponse response) throws IOException {
	
		
		Cart c = new Cart(userId,productNo);
		
		System.out.println("장바구니 숫자변경 접근 확인" + c);
		
		
		
		int result = CartService.changeAmountM(c);
		
		response.getWriter().print(result);
	
		
	}
		
		
	}
	
	
	
	

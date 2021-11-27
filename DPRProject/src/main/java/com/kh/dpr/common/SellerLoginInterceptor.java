package com.kh.dpr.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.dpr.member.model.vo.Member;
import com.kh.dpr.seller.model.vo.Seller;


public class SellerLoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		Seller loginMember = (Seller)session.getAttribute("seller");

		if(loginMember == null) {

			
			request.setAttribute("loc", "/");
			request.setAttribute("msg", "로그인 후 이용해 주세요!");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}

}

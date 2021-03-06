package com.kh.dpr.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.dpr.member.model.vo.Member;
import com.kh.dpr.seller.model.vo.Seller;


public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		Member loginMember = (Member)session.getAttribute("member");
		
		Seller sellerLogin = (Seller)session.getAttribute("seller");
		
		if(sellerLogin != null) {
			request.setAttribute("loc", "/seller/sellerMain.do");
			request.setAttribute("msg", "일반 회원 로그인 후 이용해 주세요!");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			
			return false;
		}
		
		if(loginMember == null) {

			
			request.setAttribute("loc", "/");
			request.setAttribute("msg", "로그인 후 이용해 주세요!");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			
			return false;
		} 
		
		
		return super.preHandle(request, response, handler);
	}

}

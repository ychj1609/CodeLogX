package com.spring.codelog.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class UserAuthHandler implements HandlerInterceptor {

	//회원권한이 필요한 페이지 요청이 들어왔을 때 동작할 인터셉터
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		if(session.getAttribute("loginSession") == null) {
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		return true;
	}
	
}

package com.biz.grank.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.biz.grank.domain.MemberDto;
import com.biz.grank.service.MemberService;

public class RememberInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	MemberService mSercice;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession httpSession = request.getSession();
		// 로그인 된 세션 값이 없는 경우
		if(httpSession.getAttribute("userid") == null) {
			// 쿠키 가져오기
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			// 쿠키가 존재하면
			if(loginCookie != null) {
				// loginCookie에서 값가져오기
				MemberDto mDto = mSercice.checkUserWithSessionKey(loginCookie.getValue());
				// 세션에 값 담기
				httpSession.setAttribute("userid", mDto.getUserid());
				httpSession.setAttribute("name", mDto.getName());		
			}
		}
		return true;
	}

}

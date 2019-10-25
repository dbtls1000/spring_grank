package com.biz.grank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		// session 체크 값이 있으면 통과
		HttpSession httpSession = request.getSession();
		if(httpSession.getAttribute("userid") == null) {
			// 이전 페이지 가져오기
			String referer = request.getHeader("referer");
			// 주소 직접입력했을때  예) http://localhost:8080/grank/board/write
			if(referer == null) {
				// uri 값 가져오기
				String uri = request.getRequestURI();
				int index = uri.lastIndexOf("/");
				int length = uri.length();
				// 마지막 "/"뒤에 값만 가져오기 예) /board/write 이면 write만 가져오기
				uri = uri.substring(index+1,length);
				if(uri.equals("write")) {
					// uri가 Write일 때 list로 이동
					response.sendRedirect(request.getContextPath()+"/board/list");
					return false;
				} else if (uri.equals("member_delete")) {
					// uri가 member_delete일때 /로 이동
					response.sendRedirect(request.getContextPath()+"/");
					return false;
				} 
			}
			// uri 값 가져오기
			String uri = request.getRequestURI();
			int index = referer.lastIndexOf("/");
			int length = referer.length();
			// url 값 가져오기 예) /board/write 이면 write만 가져오기
			String url = referer.substring(index+1,length);
//			log.info("referer: " + referer);
//			log.info("uri: " + uri);
//			log.info("url: " + url);
			if(url.equals("write")) {
				response.sendRedirect(request.getContextPath()+"/board/list");
				return false;
			} else if (url.equals("member_delete")) {
				response.sendRedirect(request.getContextPath()+"/");
				return false;
			}
			// FlashMap
			FlashMap flashMap = new FlashMap();
			// flashMap noklogin, uri 값 담기
			flashMap.put("message","nologin");
			// 로그인 후 이동할 페이지 주소 담기
			flashMap.put("uri",uri);
			FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(flashMap, request, response);
			response.sendRedirect(referer);
			return false;
		} else {
			// 통과
			return true;
		}
	}

}

package kr.or.ddit.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler{

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {
		// auth : 로그인 정보
		if(auth != null && auth.getDetails()!=null) {
			try {
				request.getSession().invalidate();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		log.info("로그아웃진행");
		response.setStatus(HttpServletResponse.SC_OK);
		response.sendRedirect("/main");
		
	}

}

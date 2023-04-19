package kr.or.ddit.security;

import org.springframework.security.crypto.password.PasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomNoOpPasswordEncoder implements PasswordEncoder{
	
	/*
	스프링 시큐리티 5부터 기본적으로 PasswordEncoder를 지정해야 함
	제대로 하려면 USERS 테이블의 PASSWORD 컬럼에 들어갈 비밀번호를 암호화하여 저장해야 함
	
	테스트를 위해서 생성한 데이터는 암호화를 처리하지 않았으므로 아무 처리를 하지 않고 
	로그인하면 당연히 로그인 오류가 발생할 것임
	
	그래서, 암호화를 하지 않는 PasswordEncoder를 직접 구현하여 지정하면 
	로그인 시 암호화를 고려하지 않으므로 로그인이 잘 됨
	
	*/
	@Override
	public String encode(CharSequence rawPassword) {
		log.warn("before encode : " + rawPassword);
		// 인코딩 프로세스가 없음. 인코딩을 안하겠다라는 의미
		return rawPassword.toString();
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		log.warn("matches : " + rawPassword + " : " + encodedPassword);
		return rawPassword.toString().equals(encodedPassword);
	}
	
	
	
	
}

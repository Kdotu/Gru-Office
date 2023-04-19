package kr.or.ddit.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.or.ddit.mapper.EmpMapper;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

// @Service를 하지 않아도 security-context.xml에서 bean 객체를 등록함!
@Slf4j
public class CustomUserDetailsService implements UserDetailsService {

	// DI(의존성 주입)
	@Autowired
	EmpMapper empMapper;
	
	
	// 요청파라미터 : <input type="text" name="empNo"... 
	@Override
	public UserDetails loadUserByUsername(String empNo) throws UsernameNotFoundException {
		// empNo를 받아와서 empMapper.login 메소드 실행
		EmpVO empVO = new EmpVO();
		empVO.setEmpNo(empNo);

		// empVO에 해당 사원의 정보를 담아옴
 		empVO = this.empMapper.login(empVO);
		
		// 3항 연산자. memVO가 null이면 null을 리턴하고, null이 아니면 USER를 리턴
		return empVO == null ? null : new CustomUser(empVO);
		// return 되는 값은 스프링 시큐리티에서 보냄
	}
}

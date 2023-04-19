package kr.or.ddit.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import kr.or.ddit.vo.AuthrtVO;
import kr.or.ddit.vo.EmpVO;


// User : 스프링 시큐리티가 제공하고 있는 사용자 정보 클래스
public class CustomUser extends User{
	// 이 empVO 객체는 JSP에서 사용할 수 있음(spring security에서 제공)
	private EmpVO empVO;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	// 생성자
	// empVO : select한 사용자 및 권한 정보
	// EmpVO 타입의 객체 empVO를 스프링 시큐리티에서 제공해주고 있는 UsersDetails 타입으로 변환
	// 스프링 시큐리티에 회원 정보를 보내줌 -> 스프링 시큐리티에서 정보 관리 
	public CustomUser(EmpVO empVO) {
		// 1) username / 2) password / 3) authorities
		// empVO.getMemAuthVOList() : 
		// 2 ROLE_ADMIN
		// 2 ROLE_MEM
		// empVO.getMemAuthVOList().stream() : 
		// 2 ROLE_ADMIN 2 ROLE_MEM
		super(empVO.getEmpNo(), empVO.getEmpPswd(),
				getCollect(empVO));
		this.empVO = empVO;
	}
	
	public static List<SimpleGrantedAuthority> getCollect(EmpVO empVO){
		List<SimpleGrantedAuthority> authorities
		 = new ArrayList<SimpleGrantedAuthority>();
		/*
		 230301(empNo), ROLE_ADMIN(authrt)
		 230301(empNo), ROLE_MID  (authrt)
		 230301(empNo), ROLE_MEM  (authrt)
		 => empAuthVOList에 넣어줌
		*/
		List<AuthrtVO> empAuthVOList = empVO.getEmpAuthVOList();
		// AuthrtVO : 230301 ROLE_MEM
		for(AuthrtVO authrtVO : empAuthVOList) {
			// AuthrtVO.getAuth() : ROLE_MEM
			SimpleGrantedAuthority authority =
					new SimpleGrantedAuthority(authrtVO.getAuthrtNm());
			authorities.add(authority);
		}
		return authorities;
	}

	public EmpVO getEmpVO() {
		return empVO;
	}

	public void setEmpVO(EmpVO empVO) {
		this.empVO = empVO;
	}
}

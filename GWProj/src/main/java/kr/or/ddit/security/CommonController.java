package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class CommonController {

	// 접근access 거부denied 처리자handler의 URI를 지정
	// 요청URI : /accessError
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg","Access Denied");
		
		// forwarding
		// security 폴더의 accessError.jsp를 forwarding함
		return "login/accessError.empty";
	}
	
}

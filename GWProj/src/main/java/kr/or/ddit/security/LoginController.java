package kr.or.ddit.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.EmpService;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.MailSendService;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-13
 *
 */
@Slf4j
@Controller
public class LoginController {

	@Autowired
	EmpService empService;
	@Autowired
	MailSendService mailService;
	@Autowired
	FileService fileService;
	@Autowired
	CustomUserDetailsService customUserDetailsService;
	
	
	
	/**
	 * 로그인 폼으로 이동
	 * 요청 URI : /localhost/login
	 * 
	 * @return
	 */
	@GetMapping("/login")
	public String loginForm() {
		// forwarding
		return "login/loginForm.empty";
	}

	/**
	 * 회원가입 폼
	 * 요청 URI : /localhost/join
	 * @return
	 */
	@GetMapping("/join")
	public String join() {
		return "login/joinForm.empty";
	}
	
	/**
	 * 입력 정보를 DB에 저장하는 메서드
	 * 요청 URI : /localhost/joinPost
	 * @param empVO
	 * @param model
	 * @return
	 */
	@PostMapping("/joinPost")
	public String joinPost(@ModelAttribute EmpVO empVO, Model model) {
		log.info("회원가입진행");
		log.info(empVO.toString());
		// DB에 정보 입력
		int res = this.empService.join(empVO);
		
		if(res == 0) { // DB 등록 실패
			model.addAttribute("title","회원가입 실패");
			model.addAttribute("msg","회원가입이 실패했습니다. 다시 시도해주세요.");
		}else { 	   // DB 등록 성공
			model.addAttribute("title","회원가입 성공");
			model.addAttribute("msg","회원가입이 정상적으로 처리되었습니다.");
		}
		this.empService.authorizeEmp(empVO);
		// 처리 결과를 페이지에서 출력
		return "login/result.empty";
	}
	
	
	/**
	 * 웹메일을 이용하여 이메일 인증을 하는 메서드
	 * 요청 URI : /localhost/mailCheck
	 * @param email
	 * @return
	 */
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		log.info("email : " + email);
		return mailService.joinEmail(email);
	}
	
	/**
	 * 로그인 시 입력한 정보가 맞는지 체크하는 메서드
	 * 요청 URI : /localhost/loginCheck
	 * @param empVO
	 * @param redirectAttr 로그인 완료 메시지
	 * @return
	 */
	@PostMapping("/loginCheck")
	@ResponseBody
	public String loginCheck(EmpVO empVO, RedirectAttributes redirectAttr) {
		String code ="";
		log.info("empVO : " + empVO);
		EmpVO loginEmpVO = new EmpVO();
		loginEmpVO = this.empService.login(empVO);
		log.info("loginEmpVO : " + loginEmpVO);
		
		if(loginEmpVO == null) {
			code += "idError";
		}else {
			if(! loginEmpVO.getEmpPswd().equals(empVO.getEmpPswd())) {
				code +="pwError";
			}else {
				code += "loginSuccess";
				redirectAttr.addFlashAttribute("msg","로그인 완료!");
			}
		}
		return code;
	}
	
	/**
	 * 회원가입 시 아이디 중복 여부를 체크하는 메서드
	 * 요청 URI : /localhost/idCheck
	 * @param empVO
	 * @return
	 */
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(EmpVO empVO) {
		return this.empService.idCheck(empVO);
	}
	

	/**
	 * 아이디/비밀번호 찾기 페이지 요청
	 * 요청 URI : /localhost/findInfo
	 * @param find
	 * @param model
	 * @return
	 */
	@GetMapping("/findInfo")
	public String findId(String find, Model model) {
		// 아이디 찾기
		log.info("find : " + find);
		if(find.equals("id")) {
			model.addAttribute("title","아이디 찾기");
			model.addAttribute("placeholder","이름 입력...");
			model.addAttribute("value","empNm");
			model.addAttribute("btnName","btnIdFind");
		}
		// 패스워드 찾기
		if(find.equals("pw")) {
			log.info("find PW --> ");
			model.addAttribute("title","비밀번호 찾기");
			model.addAttribute("placeholder","아이디 입력...");
			model.addAttribute("value","empNo");
			model.addAttribute("btnName","btnPwFind");
		}
		log.info("find E --> ");
		return "login/findInfo.empty";
	}
	
	/**
	 * 이메일 주소로 사원정보 찾아오는 메서드
	 * 요청 URI : /localhost/findEmpInfo
	 * @param empVO
	 * @param find
	 * @return
	 */
	@PostMapping("/findEmpInfo")
	@ResponseBody
	public String findInfo(EmpVO empVO, String find) {
		log.info("Controller find : " + find);
		log.info("empVO===> " + empVO.toString());
		
		// 이메일 주소로 회원정보를 검색해옴 
		List<EmpVO> empInfo = this.empService.findInfo(empVO);
		// 이메일 주소로 검색된 회원이 있을 경우
		log.info("empInfo===> " + empInfo);
		
		if(empInfo.size() == 0) {
			return "none";
		}else {
			// 사용자가 입력한 정보와 일치하는지 체크
			if(find.equals("id")) {
				if(empInfo.get(0).getEmpNm().equals(empVO.getEmpNm())) {
					return empInfo.get(0).getEmpNo();
				}else {
					return "none";
				}
			}
			if(find.equals("pw")) {
				if(empInfo.get(0).getEmpNo().equals(empVO.getEmpNo())) {
					// 정보가 있으면 인증번호 발송 후 인증번호 반환
					String tempPswd = this.mailService.findPw(empInfo.get(0));
					empInfo.get(0).setEmpPswd(tempPswd);
					int res = this.empService.modifyEmp(empInfo.get(0));
					return String.valueOf(res);
				}else {
					return "none";
				}
			}
		}
		return "none";
	}
	
	/**
	 * 등록된 이메일 중 중복이 있는지 확인하는 메서드
	 * 요청 URI : /localhost/emailDupliChk
	 * @param empVO
	 * @return
	 */
	@PostMapping("/emailDupliChk")
	@ResponseBody
	public String emailDupliChk(EmpVO empVO) {
		String res ="used";
		// 이메일 주소로 회원정보를 검색해옴 
		List<EmpVO> empInfo = this.empService.findInfo(empVO);
		log.info("empInfo : " + empInfo);
		log.info("empInfo.size : " + empInfo.size());
		if(empInfo.size() == 0) {
			res = "none";
		}
		return res;
	}

	/**
	 * 비밀번호 변경 시 입력한 비밀번호가 맞는지 체크하는 메서드
	 * 요청 URI : /localhost/pswdChk 
	 * @param empPswd
	 * @return
	 */
	@PostMapping("/pswdChk")
	@ResponseBody
	public String pswdChk(String empPswd) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    
	    String res = "";
	    log.info("empVO.getEmpPswd() : " + empVO.getEmpPswd());
	    log.info(empVO.getEmpPswd());
	    log.info("empPswd : " + empPswd);
	    log.info(empPswd);
	    
	    if(empVO.getEmpPswd().equals(empPswd)) {
	    	res = "correct";
	    }else {
	    	res = "incorrect";
	    }
	    log.info(res);
		return res;
	}
	
	
	/**
	 * 입력한 정보로 회원정보 수정를 수정하는 메서드
	 * 요청 URI : /localhost/modifyInfo
	 * @param empVO
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/modifyInfo")
	public String modifyInfo(EmpVO empVO, RedirectAttributes redirectAttr) {
		String title = "";
	    String msg = "";
	    String keyword = "";
	    String icon = "";
	    log.info("empVO modifyInfo : " + empVO);
		int res = this.empService.modifyEmp(empVO);
		
		if(empVO.getEmpPswd() == null) { // 회원정보 수정일 경우
			keyword += "회원정보";
		}else { // 비밀번호 수정일 경우
			keyword += "비밀번호";
		}
		
		if(res > 0) {
			title += keyword +" 수정 완료!";
			msg += keyword + "가 성공적으로 수정되었습니다.";
			icon += "success";
			
		}else {
			title += keyword + " 수정 실패!";
			msg += "다시 시도해주세요.";
			icon += "error";
		}
		redirectAttr.addFlashAttribute("resultIcon",icon);
		redirectAttr.addFlashAttribute("resultMsg",msg);
		redirectAttr.addFlashAttribute("resultTitle",msg);
		
		setUserDetails();
		if(keyword.equals("회원정보")) {return "redirect:/myPage/modifyInfo";}
		return "redirect:/myPage/modifyPswd";
	}

	
	/**
	 * 회원의 첨부파일을 수정/등록하는 메서드
	 * (회원프로필 사진, 마이페이지 배경사진)
	 * @param empVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/emp/modifyFile")
	public String modifyFile(EmpVO empVO) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empNoVO = principal.getEmpVO();
	    empVO.setEmpNo(empNoVO.getEmpNo());
		log.info("empVO : " +  empVO);
		int res = this.fileService.filecreate(empVO);
		log.info("fileupload : " + empVO.getUploadFile());
		log.info("empVO222222 : " +  empVO);
		
		// 파일첨부 그룹번호 업데이트
		this.empService.updateProfile(empVO);
		
		setUserDetails();
		return res +"";
	}
	
	/**
	 * 세션에 저장된 로그인 정보 업데이트 하는 메서드
	 */
	private void setUserDetails() {
		// 이전 권한을 이용해서 정보를 불러옴
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)oldAuth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
		// 새로 설정할 정보를 username을 이용해서 설정
	      Authentication newAuth =
	    		  new PreAuthenticatedAuthenticationToken(
	    				  customUserDetailsService.loadUserByUsername(empVO.getEmpNo()), oldAuth.getCredentials(), oldAuth.getAuthorities());
	      SecurityContextHolder.getContext().setAuthentication(newAuth);
	   }
	
	
	
	
}


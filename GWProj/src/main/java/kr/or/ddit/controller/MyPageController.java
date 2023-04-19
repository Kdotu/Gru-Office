package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.AlarmService;
import kr.or.ddit.service.NoteService;
import kr.or.ddit.vo.AlarmListVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.NoteVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myPage")
public class MyPageController {

	@Autowired
	AlarmService alarmService;
	@Autowired
	NoteService noteService;


	/**
	 * 요청URL : localhost/myPage/main
	 * 마이페이지의 메인을 불러오는 메서드
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String myPageMain(Model model) {
		model.addAttribute("pageMain","My Page");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","마이페이지 메인");
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		// 알림--------------------------------------------------
		List<AlarmListVO> alarmListVOList = this.alarmService.alarmList(username);
		// -----------------------------------------------------

		// 쪽지--------------------------------------------------
		NoteVO noteVO = new NoteVO();
		noteVO.setEmpNoRcvr(username);
		List<NoteVO> recieveNtListTemp = noteService.recieveNtList(noteVO);

		//메인페이지의 쪽지 카드를 5개만 보이도록 처리
		int cnt;
		if(recieveNtListTemp.size()<5) {
			cnt = recieveNtListTemp.size();
		}else {
			cnt=5;
		};

		List<NoteVO> recieveNtList = new ArrayList<NoteVO>();
		for(int i=0;i<cnt;i++) {
			NoteVO vo = recieveNtListTemp.get(i);
			recieveNtList.add(vo);
		}

		// -----------------------------------------------------
		model.addAttribute("alarmListVOList", alarmListVOList);
		model.addAttribute("data", recieveNtList);
		return "myPage/main";
	}


	/**
	 * 요청URL : localhost/myPage/modifyInfo
	 * 마이페이지 내에서 회원 정보를 수정하는 메서드
	 * @param model
	 * @return
	 */
	@GetMapping("/modifyInfo")
	public String modifyInfo(Model model) {
		model.addAttribute("pageMain","My Page");
		model.addAttribute("pageDetail","modifyInfo");
		model.addAttribute("pageName","회원정보 수정");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empNoVO = principal.getEmpVO();
		return "myPage/modifyInfo";
	}

	/**
	 * 요청URL : localhost/myPage/modifyPswd
	 * 마이페이지 내에서 회원의 비밀번호를 변경하는 메서드
	 * @param model
	 * @return
	 */
	@GetMapping("/modifyPswd")
	public String modifyPswd(Model model) {
		model.addAttribute("pageMain","My Page");
		model.addAttribute("pageDetail","modifyPswd");
		model.addAttribute("pageName","비밀번호 변경");

		return "myPage/modifyPswd";
	}




}

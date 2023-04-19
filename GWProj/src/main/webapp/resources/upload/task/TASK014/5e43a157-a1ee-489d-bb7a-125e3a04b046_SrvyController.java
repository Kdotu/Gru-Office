package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.SrvyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/survey")
public class SrvyController {

	// 설문조사 메인
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","설문조사 메인");
		
		
		
		return "survey/main";
	}
	
	// 설문조사 목록
	// 메뉴별로 다르게 변수를 받아서 변수에 따른 목록을 불러와야겠네
	@GetMapping("/list")
	public String list(Model model,String status) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","list");
		model.addAttribute("pageName","설문조사 목록");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
		
		
		log.info("status : " + status);
		Map<String,String> surveyMap = new HashMap<String,String>();
		surveyMap.put("empNo",empVO.getEmpNo());
		
		
		
		return "survey/list";
	}
	
	// 설문 상세
	@GetMapping("/detail")
	public String detail(Model model) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","detail");
		model.addAttribute("pageName","설문조사 상세");
		
		return "survey/detail";
	}
	
	// 설문 등록
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","create");
		model.addAttribute("pageName","설문조사 등록");
		
		
		
		return "survey/create";
	}
	
	@PostMapping("/createPost")
	public String createPost(SrvyVO surveyVO, Model model) {
		log.info("surveyVO : " + surveyVO);
		
		
		
		
		return "";
	}
	
	
	
}

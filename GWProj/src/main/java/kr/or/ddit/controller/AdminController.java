package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

	@GetMapping("/main")
	public String main() {
		log.info("controller는 왔어요");
		return "admin/mainPage.admin";
	}
	
	
	
	@GetMapping("/depBList")
	public String depBList(Model model) {
		model.addAttribute("pageMain","AdminBoard");
		model.addAttribute("pageDetail","depBList");
		model.addAttribute("pageName","부서게시판");
		
		model.addAttribute("authority","admin");
		
		return "admin/depBList.admin";
	}
		
	@GetMapping("/myList")
	public String myList(Model model) {
		model.addAttribute("authority","admin");
		
		return "admin/depBList.admin";
	}
	
	
	
	
	
	@GetMapping("/detail")
	public String detail() {
		
		return "admin/detail.admin";
	}
	
	@GetMapping("/chart")
	public String chart() {
		
		return "admin/chart.admin";
	}
	
	@GetMapping("/write")
	public String write() {
		
		return "admin/write.admin";
	}
	
	@GetMapping("/org")
	public String org() {
		
		return "admin/org.admin";
	}
	
	
	@GetMapping("/empDetail")
	public String empDetail() {
		
		return "admin/empDetail.admin";
	}
	
	@GetMapping("/jbpsList")
	public String jbpsList() {
		
		return "admin/jbpsList.admin";
	}
	
	@GetMapping("/empCreate")
	public String empCreate(Model model) {
		model.addAttribute("pageMain","AdminWork");
		model.addAttribute("pageDetail","createEmp");
		model.addAttribute("pageName","사원추가");
		
		return "admin/empCreate.admin";
	}
	
}

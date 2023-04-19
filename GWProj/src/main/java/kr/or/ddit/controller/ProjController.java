package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ProjService;
import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.ProjVO;
import kr.or.ddit.vo.PrtpntVO;
import kr.or.ddit.vo.TaskCountVO;
import kr.or.ddit.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/projects")
@Controller
public class ProjController {
	@Autowired
	ProjService projService;


	/**
	 * @param model
	 * @return 프로젝트 전체 목록
	 */
	@GetMapping("/projList")
	public String projList(Model model) {
		model.addAttribute("pageMain","Works");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","Works 메인페이지");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		List<ProjVO> projVOList = this.projService.projList(username);

		model.addAttribute("projVOList", projVOList);

		return "projects/projList";
	}

	/**
	 * @param projVO
	 * @return 프로젝트를 등록한 뒤 프로젝트 목록 페이지
	 */
	@PostMapping("/create")
	public String createPost(@ModelAttribute ProjVO projVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		projVO.setEmpNo(username);

		int res = this.projService.createPost(projVO);

		if(res > 0) {
			return "redirect:/projects/projList";
		}else {
			return "redirect:/projects/projList";
		}
	}

	/**
	 * @param bookmarkVO
	 * @return 즐겨찾기로 등록된 프로젝트의 수
	 */
	@ResponseBody
	@PostMapping("/createBookmark")
	public int createBookmark(@RequestBody BookmarkVO bookmarkVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		bookmarkVO.setEmpNo(username);

		int res = this.projService.createBookmark(bookmarkVO);

		return res;
	}

	/**
	 * @param bookmarkVO
	 * @return 즐겨찾기에서 삭제된 프로젝트의 수
	 */
	@ResponseBody
	@PostMapping("/deleteBookmark")
	public int deleteBookmark(@RequestBody BookmarkVO bookmarkVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		bookmarkVO.setEmpNo(username);

		int res = this.projService.deleteBookmark(bookmarkVO);

		return res;
	}

	/**
	 * @param projVO
	 * @param model
	 * @return 프로젝트 상세보기
	 */
	@GetMapping("/projDetail")
	public String projDetail(@ModelAttribute ProjVO projVO, Model model) {
		model.addAttribute("pageMain","Works");
		model.addAttribute("pageDetail","projDetail");
		model.addAttribute("pageName","프로젝트 상세페이지");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		projVO.setEmpNo(username);


		ProjVO tProjVO = this.projService.projTaskDetail(projVO.getProjNo());
		projVO = this.projService.projDetail(projVO);
		List<ProjVO> projVOList = this.projService.projList(username);
		TaskCountVO taskCountVO = this.projService.taskCount(projVO);
		List<ProjVO> empList = this.projService.empList();

		//프로젝트 + 참여자 정보
		model.addAttribute("projVO", projVO);
		//프로젝트 + 태스크 정보
		model.addAttribute("tProjVO", tProjVO);
		//프로젝트 목록(드롭다운 메뉴)
		model.addAttribute("projVOList", projVOList);
		//태스크 수
		model.addAttribute("taskCountVO", taskCountVO);
		//전체 사원 목록
		model.addAttribute("empList", empList);

		return "projects/projDetail";
	}

	/**
	 * @param prtpntVO
	 * @return 프로젝트의 참여자 목록
	 */
	@ResponseBody
	@PostMapping("/prtList")
	public List<PrtpntVO> prtList(@RequestBody PrtpntVO prtpntVO)  {
		List<PrtpntVO> projPrtList = projService.prtList(prtpntVO);

	    return projPrtList;
	}

	/**
	 * @param projVO
	 * @return 삭제된 프로젝트의 수
	 */
	@ResponseBody
	@PostMapping("/projDelete")
	public int projDelete(@RequestBody ProjVO projVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		projVO.setEmpNo(username);

		int res = this.projService.projDelete(projVO);

		return res;
	}

	//프로젝트 복구
	/**
	 * @param projVO
	 * @return 복구된 프로젝트의 수
	 */
	@ResponseBody
	@PostMapping("/remake")
	public int remake(@RequestBody ProjVO projVO) {
		int res = this.projService.remake(projVO);

		return res;
	}

	//프로젝트 참여자 등록
	/**
	 * @param prtpntVO
	 * @return 프로젝트에 참여자로 등록된 사원의 수
	 */
	@ResponseBody
	@PostMapping("/projPrtAdd")
	public int projPrtAdd(@RequestBody PrtpntVO prtpntVO) {
		int projPrtAdd = this.projService.projPrtAdd(prtpntVO);

		return projPrtAdd;

	}
}

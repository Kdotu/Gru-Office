package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.TodoService;
import kr.or.ddit.vo.CalVO;
import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.TodoVO;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import sun.util.logging.resources.logging;

@Slf4j
@Controller
@RequestMapping("/Todo")
public class TodoController {
	@Autowired
	TodoService todoservice;

	/**
	 * 체크리스트 메인페이지 리턴
	 * @param todoVO
	 * @param chkVO
	 * @param model
	 * @return "todo/main";
	 */
	@GetMapping("/main")
	public String todoMain(@ModelAttribute TodoVO todoVO, ChkVO chkVO, Model model) {
		model.addAttribute("pageMain","My Page");
		model.addAttribute("pageDetail","Check List");
		model.addAttribute("pageName","체크리스트");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();

		EmpVO empVO = principal.getEmpVO();
		
		String empNo = empVO.getEmpNo();
		todoVO.setEmpNo(empNo);
		
		List<TodoVO> todoVOList = todoservice.getTodo(todoVO);
		
		model.addAttribute(todoVOList);
		
		return "todo/main";
	}
	
	/**
	 * 체크리스트 전체 정보를 검색하여 불러옴.(체크리스트 메인페이지용)
	 * @param todoVO
	 * @param chkVO
	 * @param model
	 * @return todoVOList
	 */
	@GetMapping("/mainHeader")
	@ResponseBody
	public List<TodoVO> mainHeader(@ModelAttribute TodoVO todoVO, ChkVO chkVO, Model model) {
		model.addAttribute("pageMain","My Page");
		model.addAttribute("pageDetail","Check List");
		model.addAttribute("pageName","체크리스트");
		
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		
		EmpVO empVO = principal.getEmpVO();
		
		String empNo = empVO.getEmpNo();
		todoVO.setEmpNo(empNo);
		
		List<TodoVO> todoVOList = todoservice.getTodo(todoVO);
		
		//model.addAttribute("todoVOList", todoVOList);
		
		return todoVOList;
	}
	
	/**
	 * 새 할일 보드를 추가
	 * @param todoNm
	 * @param firChkCn
	 * @return "redirect:/Todo/main";
	 */
	@PostMapping("/createTodo")
	public String createTodo(@RequestParam("todoNm") String todoNm, @RequestParam("firChkCn") String firChkCn) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		
		EmpVO empVO = principal.getEmpVO();
		String empNo = empVO.getEmpNo();
		
		TodoVO todoVO = new TodoVO();
		todoVO.setTodoNm(todoNm);
		todoVO.setEmpNo(empNo);
		
		ChkVO chkVO = new ChkVO();
		chkVO.setChkCn(firChkCn);
		
		log.info("들어옴 값1 : " + todoVO + "값2 : " + chkVO);
		
		int result = todoservice.createTodo(todoVO, chkVO);
		return "redirect:/Todo/main";
	}
	
	/**
	 * 새 할일 추가 후 새로 생성된 테이블의 행수를 리턴
	 * @param chkVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/createChk")
	public int createChk(@RequestBody ChkVO chkVO) throws Exception {
		log.info("새 할일 추가시 ChkVO : " + chkVO);
		
	    int result = todoservice.createChk(chkVO);
	    return result;
	}
	
	/**
	 * 할일 삭제 후 삭제된 테이블의 행수를 리턴
	 * @param chkVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteChk")
	public int deleteChk(@RequestBody ChkVO chkVO) throws Exception {
		log.info("할일 삭제시 ChkVO : " + chkVO);
		
		int result = todoservice.deleteChk(chkVO);
		return result;
	}
	
	/**
	 * 할일 체크여부만 수정 후 수정된 테이블의 행수를 리턴
	 * @param chkVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/updateChkYN")
	public int updateChkYN(@RequestBody ChkVO chkVO) throws Exception {
		log.info("할일 YN 수정시 ChkVO : " + chkVO);
		
		int result = todoservice.updateChkYN(chkVO);
		return result;
	}
	
	/**
	 * 체크리스트 제목 수정 후 수정된 테이블의 행수를 리턴
	 * @param chkVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/updateChk")
	public int updateChk(@RequestBody ChkVO chkVO) throws Exception {
		log.info("할일 YN 수정시 ChkVO : " + chkVO);
		
		int result = todoservice.updateChk(chkVO);
		return result;
	}
	
	/**
	 * 새 할일 보드 삭제 후 삭제된 행 수 리턴
	 * @param todoVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteTodo")
	public int deleteTodo(@RequestBody TodoVO todoVO) throws Exception {
		log.info("새 할일 삭제시 todoVO : " + todoVO);
		
		int result = todoservice.deleteTodo(todoVO);
		return result;
	}
	
	/**
	 * 새 할일 보드 제목 수정 후 수정된 행 수 리턴
	 * @param todoVO
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/updateTodo")
	public int updateTodo(@RequestBody TodoVO todoVO) throws Exception {
		log.info("새 할일 제목 변경 시 todoVO : " + todoVO);
		
		int result = todoservice.updateTodo(todoVO);
		return result;
	}
	
	
}

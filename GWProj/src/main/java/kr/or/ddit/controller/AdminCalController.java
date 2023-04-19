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
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.CalService;
import kr.or.ddit.vo.CalVO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminCalController {

	@Autowired
	CalService calService;

	/**
	 * 관리자 캘린더 정보 불러오기
	 * @param calVO
	 * @param model
	 * @return calVOListString
	 * @throws JsonProcessingException
	 */
	@GetMapping("/getAdminCal")
	@ResponseBody
	public String getAdminCal (@ModelAttribute CalVO calVO, Model model) throws JsonProcessingException {

		//관리자 계정 번호
		String empNo = "202300";
		calVO.setEmpNo(empNo);

		List<CalVO> calVOList = calService.getCal(calVO);

		// jackson objectmapper 객체 생성
		ObjectMapper mapper = new ObjectMapper();

		// 관리자 일정을 받아와 json String 형식으로 매핑
		String calVOListString =  mapper.writeValueAsString(calVOList);
		log.info("getCal : " + calVOListString);
		
		model.addAttribute(calVOList);
		return calVOListString;
	}

	/**
	 * 수정, 삭제가  가능한 내 캘린더페이지 불러옴
	 * @param model
	 * @return "admin/calendarAdmin.empty3";
	 */
	@GetMapping("/calendar")
	public String calender(Model model) {
		//관리자 사원번호
		EmpVO empVO = calService.getEmp();
		String empNo = empVO.getEmpNo();
		String empNm = empVO.getEmpNm();
		log.info("값 확인sdsdda  empNo : " + empNo);
		
		model.addAttribute("empNoCo",empNo);
		model.addAttribute("empNmCo",empNm);
		return "admin/calendarAdmin.empty3";
	}

	/**
	 * 전사일정 캘린더 페이지용 프레임 호출 (캘린더 호출보다 먼저 실행됨==최우선 실행)
	 * @param model
	 * @return "admin/calFrameAdmin.admin";
	 */
	@GetMapping("/calFrame")
	public String calFrame(Model model) {
		
		//관리자 사원번호
		EmpVO empVO = calService.getEmp();
		String empNo = empVO.getEmpNo();
		String empNm = empVO.getEmpNm();
		
		//기타 보낼 정보들
		model.addAttribute("pageMain","AdminCalendar");
		model.addAttribute("pageDetail","myCalendar");
		model.addAttribute("pageName","일정");
		model.addAttribute("empNoCo",empNo);
		model.addAttribute("empNmCo",empNm);
		
		
		log.info("값 확인  empNo : " + empNo);
		log.info("값 확인  empNm : " + empNm);
		
		//전사일정 수정, 삭제가 가능한 admin캘린더로 간다.
		return "admin/calFrameAdmin.admin";
	}

	/**
	 * 일정 추가 후 그 결과가 적용된 테이블의 행 수 리턴
	 * @param calVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/createCalender")
	public int createCalender(@RequestBody CalVO calVO) throws Exception {
		log.info("일정추가시 calVO : " + calVO);

	    int result = calService.createCalender(calVO);
	    return result;
	}

	/**
	 * 일정 수정 후 그 결과가 적용된 테이블의 행 수 리턴
	 * @param calVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/updateCalender")
	public int updateCalender(@RequestBody CalVO calVO) throws Exception {
		log.info("일정수정시 calVO : " + calVO);

		int result = calService.updateCalender(calVO);
		return result;
	}

	/**
	 * 일정 날짜변경 후 그 결과가 적용된 테이블의 행 수 리턴
	 * @param calVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/updateCalenderDay")
	public int updateCalenderDay(@RequestBody CalVO calVO) throws Exception {
		log.info("날짜변경시 calVO : " + calVO);

		int result = calService.updateCalenderDay(calVO);
		return result;
	}

	/**
	 * 일정 삭제 후 그 결과가 적용된 테이블의 행 수 리턴
	 * @param calVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteCalender")
	public int deleteCalender(@RequestBody CalVO calVO) throws Exception {
		log.info("삭제");
		int result = calService.deleteCalender(calVO);
		return result;
	}

}

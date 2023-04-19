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
@RequestMapping("/cal")
public class CalController {

	@Autowired
	CalService calService;

	/**
	 * 내 캘린더 정보 불러오기
	 * @param calVO
	 * @param model
	 * @return calVOListString
	 * @throws JsonProcessingException
	 */
	@GetMapping("/getCal")
	@ResponseBody
	public String getCal(@ModelAttribute CalVO calVO, Model model) throws JsonProcessingException {
		
		//내 회원정보 불러오기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();

		EmpVO empVO = principal.getEmpVO();

		String empNo = empVO.getEmpNo();
		calVO.setEmpNo(empNo);

		//캘린더 일정 불러오기
		List<CalVO> calVOList = calService.getCal(calVO);

		// jackson objectmapper 객체 생성
		ObjectMapper mapper = new ObjectMapper();

		String calVOListString =  mapper.writeValueAsString(calVOList);
		log.info("getCal : " + calVOListString);
		
		//캘린더 리스트 보냄
		model.addAttribute(calVOList);
		return calVOListString;
	}

	/**
	 * 다른 사람의 캘린더 정보 불러오기
	 * @param empVO
	 * @param model
	 * @return calVOListString
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@GetMapping("/getCal2")
	public String getCal2(EmpVO empVO, Model model) throws JsonProcessingException {

		CalVO calVO = new CalVO();

		String empNo = empVO.getEmpNo();
		calVO.setEmpNo(empNo);

		//다른사람의 정보로 다른사람 캘린더를 불러온다
		List<CalVO> calVOList = calService.getCalAnother(calVO);

		// jackson objectmapper 객체 생성
		ObjectMapper mapper = new ObjectMapper();

		String calVOListString =  mapper.writeValueAsString(calVOList);
		log.info("getCal : " + calVOListString);

		model.addAttribute(calVOList);
		return calVOListString;
	}

	/**
	 * 수정, 삭제가  가능한 내 캘린더 불러오기
	 * @return "calendar/calendar.empty3";
	 */
	@GetMapping("/calendar")
	public String calender() {
		return "calendar/calendar.empty3";
	}

	/**
	 * 보는것만 가능한 다른 사람의 캘린더 페이지 불러오기
	 * @param empVO
	 * @param model
	 * @return "calendar/calendar2.empty3";
	 */
	@GetMapping("/calendar2")
	public String calender2(@ModelAttribute EmpVO empVO, Model model) {
		
		String empNo = empVO.getEmpNo();
		String empNm = empVO.getEmpNm();
		
		model.addAttribute("empNo", empNo);
		model.addAttribute("empNm", empNm);
		
		return "calendar/calendar2.empty3";
	}

	/**
	 * 캘린더 페이지를 집어넣을 프레임 호출 (캘린더 호출보다 먼저 실행됨==최우선 실행)
	 * @param empVO
	 * @param model
	 * @return "calendar/calFrame2";
	 */
	@GetMapping("/calFrame")
	public String calFrame(@ModelAttribute EmpVO empVO, Model model) {
		//내 로그인 아이디의 사원번호 찾기
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();

		//내 사원번호
		EmpVO empVOMy = principal.getEmpVO();
		String empNoMy = empVOMy.getEmpNo();

		//get으로 얻은 사원번호
		String empNoGet = empVO.getEmpNo();
		String empNmGet = empVO.getEmpNm();

		//기타 보낼 정보들
		model.addAttribute("pageMain","Calendar");
		model.addAttribute("pageDetail","myCalendar");
		model.addAttribute("pageName","일정");

		// 만약, empNoGet을 받지 않고 호출받거나 호출받은 empNoGet값이 empNoMy와 같으면
		if(empNoGet ==null || empNoMy.equals(empNoGet)) {
			log.info("같다!");
			model.addAttribute("empNo",empNoMy);
			
			//수정, 삭제가 가능한 내 캘린더로 간다.
			return "calendar/calFrame";
		}
		//그 외의 경우에는 전부
		log.info("다르다!");
		model.addAttribute("empNo",empNoGet);
		model.addAttribute("empNm",empNmGet);
		
		//수정, 삭제가 불가능하고 보는것만 가능한 다른 사람의 캘린더로 간다.
		return "calendar/calFrame2";
	}

	/**
	 * 일정 추가
	 * @param calVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/createCalender")
	public int createCalender(@RequestBody CalVO calVO) throws Exception {
		log.info("calVO : " + calVO);

	    int result = calService.createCalender(calVO);
	    return result;
	}

	/**
	 * 기존 일정 수정
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
	 * 드래그 앤 드롭으로 날짜만 변경 시
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
	 * 기존 일정 삭제 시
	 * @param calVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteCalender")
	public int deleteCalender(@RequestBody CalVO calVO) throws Exception {
		
		int result = calService.deleteCalender(calVO);
		return result;
	}

}

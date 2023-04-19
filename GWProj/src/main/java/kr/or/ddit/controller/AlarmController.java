package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.AlarmService;
import kr.or.ddit.vo.AlarmListVO;
import kr.or.ddit.vo.AlarmRecvVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@EnableAsync
@RequestMapping("/alarm")
@Controller
public class AlarmController {
	@Autowired
	AlarmService alarmService;

	/**
	 * @return 헤더의 배지에 표시될 읽지 않은 알림의 개수
	 */
	@ResponseBody
	@PostMapping("/alarmCount")
	public int alarmCount() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		int result = this.alarmService.alarmCount(username);

		return result;
	}

	/**
	 * @param model
	 * @return 알림 전체 목록
	 */
	@GetMapping("/main")
	public String alarmList(Model model) {
		model.addAttribute("pageMain","My Page");
		model.addAttribute("pageDetail","alarm");
		model.addAttribute("pageName","알림목록");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		List<AlarmListVO> alarmListVOList = this.alarmService.alarmList(username);
		model.addAttribute("alarmListVOList", alarmListVOList);

		return "alarm/alarmMain";
	}

	/**
	 * @param alarmListVO
	 * @return 삭제된 알림의 수
	 */
	@ResponseBody
	@PostMapping("/deleteAlarm")
	public int deleteAlarm(@RequestBody AlarmListVO alarmListVO) {
		int deleteAlarm = this.alarmService.deleteAlarm(alarmListVO);

		return deleteAlarm;
	}

	/**
	 * @param alarmListVO
	 * @return 삭제된 알림의 수(전체삭제)
	 */
	@ResponseBody
	@PostMapping("/deleteAllAlarm")
	public int deleteAllAlarm(@RequestBody AlarmListVO alarmListVO) {
		int deleteAllAlarm = this.alarmService.deleteAllAlarm(alarmListVO);

		return deleteAllAlarm;
	}

	/**
	 * @param alarmRecvVO
	 * @return 확인한 알림의 수
	 */
	@ResponseBody
	@PostMapping("/checkAlarm")
	public int checkAlarm(@RequestBody AlarmRecvVO alarmRecvVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();
		alarmRecvVO.setEmpNo(username);

		int checkAlarm = this.alarmService.checkAlarm(alarmRecvVO);

		return checkAlarm;
	}

	/**
	 * @return 헤더에 표시될 알림 목록
	 */
	@ResponseBody
	@PostMapping("/mainHeader")
	public List<AlarmListVO> mainHeader() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();

		List<AlarmListVO> alarmListVOList = this.alarmService.mainHeader(username);

		return alarmListVOList;
	}

}

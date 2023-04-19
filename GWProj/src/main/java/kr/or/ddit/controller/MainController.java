package kr.or.ddit.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.CalService;
import kr.or.ddit.service.DailyReportService;
import kr.or.ddit.service.EdocService;
import kr.or.ddit.service.MailService;
import kr.or.ddit.service.ProjService;
import kr.or.ddit.service.ReserveService;
import kr.or.ddit.vo.AtrzLineInfoVO;
import kr.or.ddit.vo.DailyReportVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ProjVO;
import kr.or.ddit.vo.VhrRsvtVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {

	@Autowired
	DailyReportService dailyReportService;
	@Autowired
	CalService calService;
	@Autowired
	ReserveService reserveService;
	@Autowired
	ProjService projService;
	@Autowired
	EdocService edocService;
	@Autowired
	MailService mailService;

	/**
	 * 메인페이지
	 * 요청URL : /main
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("pageMain","main");
		model.addAttribute("pageDetail","");
		model.addAttribute("pageName","메인페이지");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();

	    // 일일업무보고----------------------------------------------------------------
	    Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String formattedDate = format.format(today);
		Calendar todayCal = Calendar.getInstance();
		todayCal.add(Calendar.WEEK_OF_MONTH,0);

	    HashMap<String, String> dateMap = new HashMap<String, String>();
	    DailyReportVO dateVO = new DailyReportVO();

	    dateMap.put("empNo",empVO.getEmpNo());
	    dateMap.put("dateInfo","today");
	    dateVO = this.dailyReportService.dateList(dateMap);
	    model.addAttribute("todayVO",dateVO);
	    model.addAttribute("today",today);
	    model.addAttribute("thisWeek",(todayCal.WEEK_OF_MONTH-1));

		int totalMemCount = this.dailyReportService.getDeptMemCount(empVO.getEmpNo()); // 전체 부서원 수
		int reportMemCount = this.dailyReportService.getDeptMemListCount(empVO.getEmpNo()); // 보고 현황수
		int nonChkReportCount = this.dailyReportService.nonChkReportCount(empVO.getEmpNo());// 미확인 일일보고 수 구하기
		int todayChkReportCount = this.dailyReportService.todayChkReportCount(empVO.getEmpNo());// 오늘자 확인한 일일업무보고

		model.addAttribute("totalMemCount",totalMemCount);
		model.addAttribute("reportMemCount",reportMemCount);
		model.addAttribute("nonChkReportCount",nonChkReportCount);
		model.addAttribute("todayChkReportCount",todayChkReportCount);
	    // ---------------------------------------------------------------------------

		// ----오늘 온 메일 수 출력------------------------------------------------------
		int todayMailCnt = mailService.todayMailCnt(empVO);
		model.addAttribute("todayMailCnt",todayMailCnt);
		// ----오늘자 일정(캘린더)수 출력------------------------------------------------------
		int totalTodayCount = calService.todayCalCount(empVO);
		model.addAttribute("totalTodayCount",totalTodayCount);
		// ----오늘자 회의실 예약 출력--------------------------------------------------------
		int resRoonTodayCount = reserveService.resRoomTodayCount(empVO);
		model.addAttribute("resRoonTodayCount",resRoonTodayCount);
		// ----오늘자 차량 예약목록 출력 ---------------------------------------------------------
		List<VhrRsvtVO> resCarTodayList = reserveService.resCarTodayList(empVO);
		model.addAttribute("resCarTodayList",resCarTodayList);

        //로그인한 사원이 참여중인 프로젝트 목록 ---------------------------------------------------------
		List<ProjVO> mainProjList = projService.mainProjList(empVO);
		model.addAttribute("mainProjList",mainProjList);

		//결재할문서가져오기 ---------------------------------------------------------
		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);

		pagingVO.setCurrentPage(1);
	    pagingVO.setEmpNo(empVO.getEmpNo());

		int totalRecord = this.edocService.getApproveTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<Map<String,Object>> dataMapList = this.edocService.getApprove(pagingVO);
		pagingVO.setDataMapList(dataMapList);

		model.addAttribute("pagingVO",pagingVO);

		return "main/mainPage";

	}


}

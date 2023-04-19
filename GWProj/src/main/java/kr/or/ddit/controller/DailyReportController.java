package kr.or.ddit.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.DailyReportService;
import kr.or.ddit.service.EmpService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.DailyReportVO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dailyReport")
public class DailyReportController {

	@Autowired
	DailyReportService dailyReportService;
	@Autowired
	EmpService empService;


	/**
	 * 요청URL : localhost/dailyReport/main
	 * 일일 업무보고 메인 페이지
	 * @param model
	 * @param currentPage 현재 페이지
	 * @param dateArr1 검색 시작일자
	 * @param dateArr2 검색 종료일자
	 * @return
	 */
	@GetMapping("/main")
	public String main(Model model,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="dateArr1", required = false) String dateArr1,
			@RequestParam(value="dateArr2", required = false) String dateArr2) {
		model.addAttribute("pageMain","Daily Report");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","일일업무보고 메인");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

	    // 금일, 전일 업무 목표 출력용
	    HashMap<String, String> dateMap = new HashMap<String, String>();
	    DailyReportVO dateVO = new DailyReportVO();

	    // 전일 정보
	    dateMap.put("empNo",empVO.getEmpNo());
	    dateMap.put("dateInfo","yesterday");
	    dateVO = this.dailyReportService.dateList(dateMap);
	    model.addAttribute("yesterDayVO",dateVO);
	    dateMap.clear();

	    // 금일 정보
	    dateMap.put("empNo",empVO.getEmpNo());
	    dateMap.put("dateInfo","today");
	    dateVO = this.dailyReportService.dateList(dateMap);
	    model.addAttribute("todayVO",dateVO);
	    log.info("today : " + dateVO);

	    //오늘 날짜
	    Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String formattedDate = format.format(today);
		Calendar todayCal = Calendar.getInstance();
		todayCal.add(Calendar.WEEK_OF_MONTH,0);
		log.info("todayCal : " + todayCal);
		log.info("todayCal.WEEK_OF_MONTH : " + (todayCal.WEEK_OF_MONTH-1));

		// 일주일 전 날짜
		Calendar calendar7 = Calendar.getInstance();
		calendar7.add(Calendar.DAY_OF_MONTH, -6);
		Date lastWeek = calendar7.getTime();

	    // 목록출력 페이징 처리용
	    int size=10;
		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo",empVO.getEmpNo());
	    map.put("size", size+"");
	    map.put("currentPage", currentPage+"");
	    map.put("dateArr1", format.format(lastWeek));
	    map.put("dateArr2", formattedDate);

	    // 이전 업무목록 출력용
		List<DailyReportVO> dailyReportVOAllList = this.dailyReportService.getAllList(map);
		log.info("dailyReportVOAllList : " + dailyReportVOAllList.toString());
		model.addAttribute("dailyReportVOAllList",dailyReportVOAllList);
		model.addAttribute("today",today);
		model.addAttribute("thisWeek",(todayCal.WEEK_OF_MONTH-1));
		return "dailyReport/main";
	}

	/**
	 * 요청URL : localhost/dailyReport/deptReport
	 * 부서 업무보고 현황조회 메인
	 * @param model
	 * @return
	 */
	@GetMapping("/deptReport")
	public String deptReport(Model model) {
		model.addAttribute("pageMain","Daily Report");
		model.addAttribute("pageDetail","dept list");
		model.addAttribute("pageName","부서 일일업무보고 현황");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		String empNo = empVO.getEmpNo();

		int totalMemCount = this.dailyReportService.getDeptMemCount(empNo); // 전체 부서원 수
		int reportMemCount = this.dailyReportService.getDeptMemListCount(empNo); // 보고 현황수

		// 차트출력용
		DailyReportVO deptReportchartVO = this.dailyReportService.deptReportChart(empNo);
		List<Map<String,String>> deptReportWeek = this.dailyReportService.deptReportDepWeekChart(empNo);
		List<Map<String,String>> deptReportDay = this.dailyReportService.deptReportDepDayChart(empNo);
		List<Map<String,String>> deptReportMonth = this.dailyReportService.deptReportDepMonthChart(empNo);
//		log.info("deptReportchartVO : " + deptReportchartVO);
//		log.info("deptReportDay : " + deptReportDay);
//		log.info("deptReportMonth : " + deptReportMonth);
		log.info("deptReportWeek : " + deptReportWeek);

	    //오늘 날짜
	    Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		String formattedDate = format.format(today);
		Calendar todayCal = Calendar.getInstance();
		todayCal.add(Calendar.WEEK_OF_MONTH,0);

		// 일주일 전 날짜
		Calendar calendar7 = Calendar.getInstance();
		calendar7.add(Calendar.DAY_OF_MONTH, -6);
		Date lastWeek = calendar7.getTime();

	    // 목록출력 페이징 처리용
		int size=5;
		int currentPage = 1;
		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo",empVO.getEmpNo());
	    map.put("size", size+"");
	    map.put("currentPage", currentPage+"");
	    map.put("dateArr1", format.format(lastWeek));
	    map.put("dateArr2", formattedDate);

	    //전체 행의 수 구하기
		int total = this.dailyReportService.getDeptReportTotal(map);
		//일일보고 전체 목록 구하기
		List<DailyReportVO> dailyReportVOList = this.dailyReportService.getDeptList(map);
		// 미확인 일일보고 수 구하기
		int nonChkReportCount = this.dailyReportService.nonChkReportCount(empNo);
		// 오늘자 확인한 일일업무보고
		int todayChkReportCount = this.dailyReportService.todayChkReportCount(empVO.getEmpNo());

		// 이번주 보고현황 목록
		List<DailyReportVO> weekReportList = this.dailyReportService.getWeekReport(empVO.getEmpNo());

		model.addAttribute("deptReportMonth",deptReportMonth);
		model.addAttribute("deptReportWeek",deptReportWeek);
		model.addAttribute("deptReportDay",deptReportDay);
		model.addAttribute("deptReportchartVO",deptReportchartVO);
		model.addAttribute("weekReportList",weekReportList);
		model.addAttribute("totalMemCount",totalMemCount);
		model.addAttribute("reportMemCount",reportMemCount);
		model.addAttribute("data", new ArticlePage<DailyReportVO>(total, currentPage, size, dailyReportVOList));
		model.addAttribute("nonChkReportCount",nonChkReportCount);
		model.addAttribute("todayChkReportCount",todayChkReportCount);
		model.addAttribute("today",today);
		model.addAttribute("thisWeek",(todayCal.WEEK_OF_MONTH-1));

		return "dailyReport/deptReport";
	}

	/**
	 * 요청URL : localhost/dailyReport/deptReport
	 * 일일업무보고 작성페이지
	 * @param model
	 * @return
	 */
	@GetMapping("/create")
	public String create(Model model) {
		model.addAttribute("pageMain","Daily Report");
		model.addAttribute("pageDetail","create");
		model.addAttribute("pageName","일일업무보고 작성");

		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		format = new SimpleDateFormat("yyyy-MM-dd (E)", Locale.KOREAN);
		//DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.FULL);
		String formattedDate = format.format(date);
		log.info("formattedDate : " + formattedDate);

		model.addAttribute("serverDate", formattedDate );
		model.addAttribute("btnForm","작성");

		return "dailyReport/reportForm";
	}


	/**
	 * 요청URL : localhost/dailyReport/detail
	 * 일일업무보고 상세 페이지
	 * @param dailyReportVO
	 * @param model
	 * @return
	 */
	@GetMapping("/detail")
	public String detail(DailyReportVO dailyReportVO, Model model) {
		model.addAttribute("pageMain","Daily Report");
		model.addAttribute("pageDetail","detail");
		model.addAttribute("pageName","일일업무보고 상세");

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateInstance(DateFormat.FULL);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverDate", formattedDate );

		dailyReportVO = this.dailyReportService.getReportDetail(dailyReportVO);
		List<EmpVO> reportEmpList = this.empService.getEmpInfo(dailyReportVO.getEmpNo());

		log.info("dailyReportVO 받아오는 정보 체크 : " + dailyReportVO);

		model.addAttribute("btnForm","수정");
		model.addAttribute("dailyReportVO",dailyReportVO);
		model.addAttribute("reportEmpList",reportEmpList);
		model.addAttribute("readonly","readonly");
		return "dailyReport/reportForm";
	}

	/**
	 *  요청URL : localhost/dailyReport/reportChk
	 *  사원의 당일 일일업무보고 번호를 가져오는 메소드
	 * @param dailyRVO
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/reportChk")
	public String reportChk(DailyReportVO dailyRVO) {
		log.info(dailyRVO.toString());
		dailyRVO = this.dailyReportService.getCreateReportNo(dailyRVO);
		return dailyRVO.getRptpNo();
	}

	/**
	 * 요청URL : localhost/dailyReport/reportRegistCheck
	 * 일일 업무보고 작성했는지 여부 체크
	 * @param dailyRVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/reportRegistCheck")
	public String reportRegistCheck(DailyReportVO dailyRVO) {
	    log.info(dailyRVO.toString());

		int res = this.dailyReportService.checkReport(dailyRVO);
		log.info("res : " + res);
		return res + "";
	}

	/**
	 * 일일 업무보고 작성
	 * @param dailyRVO
	 * @param model
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/createReport")
	public String createReport(DailyReportVO dailyRVO, Model model,RedirectAttributes redirectAttr) {
		log.info("dailyRVO : " + dailyRVO);

		dailyRVO.setRptpCmptnYn("N");

		int res = this.dailyReportService.createReport(dailyRVO);
		if(res=='0') {
			model.addAttribute("dailyRVO",dailyRVO);
			// insert 실패 시 작성 페이지로 다시 돌아감
			return "dailyReport/create";
		}

		// 방금 작성한 게시글 번호를 가져옴
		dailyRVO = this.dailyReportService.getCreateReportNo(dailyRVO);
		model.addAttribute("","");// 등록완료 문구 띄우기

		redirectAttr.addFlashAttribute("status","등록완료");
		return "redirect:/dailyReport/detail?rptpNo="+dailyRVO.getRptpNo();
	}


	/**
	 * 일일업무보고 수정
	 * @param dailyRVO
	 * @param model
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/modify")
	public String modifyReport(DailyReportVO dailyRVO, Model model,RedirectAttributes redirectAttr) {
//		int res = this.dailyReportService.modifyReport(dailyRVO);
		int res = this.dailyReportService.createReport(dailyRVO);

		if(res == 0) { // 수정실패
			// 이전 화면으로 dispatcher
			model.addAttribute("dailyRVO",dailyRVO);
			return "dailyReport/detail?rptpNo="+dailyRVO.getRptpNo();
		}
		// 수정 후 상세 화면으로
		redirectAttr.addFlashAttribute("status","수정완료");
		return "redirect:/dailyReport/detail?rptpNo="+dailyRVO.getRptpNo();

	}

	/**
	 * 일일 업무보고 목록조회
	 * @param model
	 * @param type
	 * @param currentPage
	 * @param dateArr1
	 * @param dateArr2
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model,String type,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="dateArr1", required = false) String dateArr1,
			@RequestParam(value="dateArr2", required = false) String dateArr2) {
		model.addAttribute("pageMain","Daily Report");
		model.addAttribute("pageDetail","list");
		model.addAttribute("pageName","일일업무보고 목록");
		model.addAttribute("list_type","사원별");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

	    int size=10;

		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo",empVO.getEmpNo());
	    map.put("size", size+"");
	    map.put("currentPage", currentPage+"");
	    map.put("dateArr1", dateArr1);
	    map.put("dateArr2", dateArr2);

	    //전체 행의 수 구하기
		int total = dailyReportService.getEmpReportTotal(map);

		//일일보고 전체 목록 구하기
		List<DailyReportVO> dailyReportVOList = this.dailyReportService.getAllList(map);
		model.addAttribute("pNo",currentPage);
		model.addAttribute("data", new ArticlePage<DailyReportVO>(total, currentPage, size, dailyReportVOList));
		model.addAttribute("dateArr1", dateArr1);
		model.addAttribute("dateArr2", dateArr2);

		return "dailyReport/list";
	}

	/**
	 * 부서별 일일 업무보고 목록조회
	 * @param model
	 * @param type
	 * @param currentPage
	 * @param deptNo
	 * @param dateArr1
	 * @param dateArr2
	 * @return
	 */
	@GetMapping("/deptlist")
	public String deptlist(Model model,String type,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="deptNo", required = false) String deptNo,
			@RequestParam(value="dateArr1", required = false) String dateArr1,
			@RequestParam(value="dateArr2", required = false) String dateArr2) {
		model.addAttribute("pageMain","Daily Report");
		model.addAttribute("pageDetail","list");
		model.addAttribute("pageName","부서별 일일업무보고 목록");
		model.addAttribute("list_type","부서별");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		int size=10;

		Map<String, String> map = new HashMap<String, String>();
		map.put("empNo",empVO.getEmpNo());
	    map.put("size", size+"");
	    map.put("currentPage", currentPage+"");
	    map.put("dateArr1", dateArr1);
	    map.put("dateArr2", dateArr2);
	    map.put("deptNo",deptNo);

	    log.info("empVO : " + empVO);
	    log.info("map : " + map);

	    int total=0;
	    List<DailyReportVO> dailyReportVOList = null;
	    //최상위 부서에 속하는 직원일 때 모든 목록 가져오기
	    if(empVO.getDeptNo().equals("DEPT001")) {
	    	//전체 행의 수 구하기
	    	total = dailyReportService.getDeptReportTotalAdmin(map);
	    	//일일보고 전체 목록 구하기
	    	dailyReportVOList = this.dailyReportService.getDeptListAdmin(map);
	    }else {
	    	// 사원의 상위부서 목록 가져오기
	    	List<Map<String,String>> deptList = this.empService.getUpDeptList(empVO);
	    	log.info("deptList : " + deptList);
	    	model.addAttribute("deptList",deptList);
	    	//전체 행의 수 구하기
	    	total = dailyReportService.getDeptReportTotal(map);
	    	//일일보고 전체 목록 구하기
	    	dailyReportVOList = this.dailyReportService.getDeptList(map);
	    }
	    model.addAttribute("pNo",currentPage);
	    log.info("total--------------> " + total);
		log.info("dailyReportVOList : ",dailyReportVOList);
		model.addAttribute("data", new ArticlePage<DailyReportVO>(total, currentPage, size, dailyReportVOList));
		return "dailyReport/list";
	}

	/**
	 * 보고 확인 상태 변경를 변경하는 메서드
	 * @param dailyRVO
	 * @return
	 */
	@PostMapping("/confirmReport")
	@ResponseBody
	public int confirmReport(DailyReportVO dailyRVO) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		log.info("dailytRVO : " + dailyRVO);
		dailyRVO.setRptpCmptnPic(empVO.getEmpNo());
		int res = this.dailyReportService.confirmReport(dailyRVO);
		return res;
	}



}

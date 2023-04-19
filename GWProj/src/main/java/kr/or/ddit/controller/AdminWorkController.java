package kr.or.ddit.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.AdminWorkService;
import kr.or.ddit.service.WorkService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminWorkController {
	@Autowired
	AdminWorkService adminWorkService;
	@Autowired
	WorkService workService;


	@ResponseBody
	@PostMapping("/getEmpNo")
	public EmpVO getEmpNo() {

		EmpVO empVO = this.adminWorkService.getEmpNo();

		return empVO;
	}



	//요청URI : /admin/createEmp
	@PostMapping("/createEmp")
	public String createEmp(@ModelAttribute EmpVO empVO, Model model) {
		//empVO : EmpVO(empNo=202317, jbpsNo=JBPS003, deptNo=DEPT003, empOgdpCo=null, empPswd=null, empNm=개똥이,
		//empRrno=123456-1234567, empBrdt=Fri Mar 17 00:00:00 KST 2023, empGender=GENDER0001, empMblTelno=010-123-1234, empCoTelno=042-321-4312,
		//empEmlAddr=null, empZip=11133, empAddr=대전광역시 중구 용두동, empDaddr=333-11, empJncmpYmd=Fri Mar 24 00:00:00 KST 2023, empHdofYn=null,
		//empRsgntnYmd=null, empCrtHoli=0,
		//empAuthVOList=[AuthrtVO(authrtNo=null, empNo=202301, authrtNm=AUTH_MEM), AuthrtVO(authrtNo=null, empNo=202301, authrtNm=AUTH_MID), AuthrtVO(authrtNo=null, empNo=202301, authrtNm=null)],
		//deptNm=재무팀, jbpsNm=null, upDeptNo=null, lvl=0, workMngSsts=null, workMngDtlCn=null, workMngBgngDt=null, workMngEndDt=null)
		log.info("empVO : " + empVO);
		

		int result = this.adminWorkService.insertEmp(empVO);

		//사원목록으로 redirect
		return "redirect:/admin/empList";
	}



	@GetMapping("/empList")
	public String empList(Model model) {
		model.addAttribute("pageMain","AdminWork");
		model.addAttribute("pageDetail","empList");
		model.addAttribute("pageName","인사관리");
		
		List<EmpVO> empVOList = this.adminWorkService.getEmpList();

		model.addAttribute("empVOList", empVOList);

		return "admin/empList.admin";
	}

	@ResponseBody
	@PostMapping("/empSearch")
	public List<EmpVO> empSearch(@RequestBody Map<String,String> map) {

		log.info("empHdofYn : " + map);

		EmpVO empVO = new EmpVO();

		empVO.setEmpHdofYn(map.get("empHdofYn"));

		List<EmpVO> empList = this.adminWorkService.empSearch(empVO);

		log.info("사원목록 : empList : " + empList);
		return empList;
	}


	@GetMapping("/updateEmp")
	public String updateEmp(Model model, @ModelAttribute EmpVO empVO) {
		model.addAttribute("pageMain","AdminWork");
		model.addAttribute("pageDetail","updateEmp");
		model.addAttribute("pageName","사원상세 및 수정");
		
		log.info("empNo" + empVO.getEmpNo());

		EmpVO empvo = this.adminWorkService.updateEmp(empVO);

		log.info("empvo 권한도 제대로 들어오는지?: " + empvo);

		model.addAttribute("empvo", empvo);

		return "admin/empDetail.admin";
	}

	//직원 정보 수정 후 redirect로 해당직원의 상세 페이지로 이동
	@PostMapping("/updateEmp")
	public String updatePost(Model model, @ModelAttribute EmpVO empVO) {

		log.info("직원 수정 empVO : " + empVO);

		int result = 0;

		//직원 테이블은 update하고
		result = this.adminWorkService.updateEmpPost(empVO);


		//권한도 수정할 시
		//권한 전부 삭제 후 새로 insert
		result += this.adminWorkService.updateAuthPost(empVO.getEmpAuthVOList());

		model.addAttribute("updateComp", "Comp"); 

//		EmpVO empvo = this.adminWorkService.updateEmp(empVO);
//
//		log.info("empvo 권한도 제대로 들어오는지?: " + empvo);
//
//		model.addAttribute("empvo", empvo);

		return "redirect:/admin/updateEmp?empNo="+empVO.getEmpNo();
	}


	@ResponseBody
	@PostMapping("/empExit")
	public int empExit(@RequestBody Map<String,String> map) {
		log.info("퇴사처리할 empNo : " + map.get("empNo"));

		int result = this.adminWorkService.empExit(map);

		return result;
	}


	@ResponseBody
	@PostMapping("/empRejoin")
	public int empRejoin(@RequestBody Map<String,String> map) {
		log.info("퇴사처리할 empNo : " + map.get("empNo"));

		int result = this.adminWorkService.empRejoin(map);

		return result;
	}


	@GetMapping("/deptStatisAdmin")
	public String deptStatis(Model model,String month,String deptNo) {
		model.addAttribute("pageMain","AdminWork");
		model.addAttribute("pageDetail","deptStatisAdmin");
		model.addAttribute("pageName","부서별 근태통계");

		log.info("month : " + month);
		log.info("deptNo : " + deptNo);

	    Map<String, String> map = new HashMap<String, String>();
	    map.put("month", month);
	    map.put("deptNo", deptNo);

	    //전사원일 경우
	    if(deptNo == "" || deptNo == null) {
	       List<WorkVO> workList = this.adminWorkService.getDeptWork(map);
	       log.info("잘 나옴? workList : " +workList);

	       model.addAttribute("workList", workList);
	    }else if(deptNo != null) {
	    	//부서번호를 가지고 있을 경우
	    	List<WorkVO> workList = this.workService.getDeptWork(map);
	    	log.info("잘 나옴? workList : " +workList);

	    	model.addAttribute("workList", workList);
	    }

	    Map<String, Object> map2  = new HashMap<String, Object>();

	    //전사원일 경우
	    if(deptNo == "" || deptNo == null) {
	       map2  = this.adminWorkService.TeamMonth(map);
	       log.info("잘 나옴? map : " + map2 );

	    // 지각3번(지각수/3으로 나눈 몫을 조퇴에 +1) => 조퇴 +1
		// 조퇴3번(조퇴수/3으로 나눈 몫을 결근에 +1) => 결근 +1

			int cnt2 = Integer.parseInt((String.valueOf(map2.get("LATE"))));
			int cnt3 = Integer.parseInt((String.valueOf(map2.get("EARLY"))));
			int cnt4 = Integer.parseInt((String.valueOf(map2.get("EMPTY"))));;

			cnt3 += Math.floor(cnt2 / 3);  //조퇴
			cnt4 += Math.floor(cnt3 / 3);  //결근

			map2.put("EARLY", cnt3);
			map2.put("EMPTY", cnt4);

	   	//근태통계 count용
			model.addAttribute("map", map2);
	    }else if(deptNo != null) {
	       map2  = this.workService.TeamMonth(map);
	       log.info("잘 나옴? map : " + map2 );

	    // 지각3번(지각수/3으로 나눈 몫을 조퇴에 +1) => 조퇴 +1
		// 조퇴3번(조퇴수/3으로 나눈 몫을 결근에 +1) => 결근 +1

			int cnt2 = Integer.parseInt((String.valueOf(map2.get("LATE"))));
			int cnt3 = Integer.parseInt((String.valueOf(map2.get("EARLY"))));
			int cnt4 = Integer.parseInt((String.valueOf(map2.get("EMPTY"))));;

			cnt3 += Math.floor(cnt2 / 3);  //조퇴
			cnt4 += Math.floor(cnt3 / 3);  //결근

			map2.put("EARLY", cnt3);
			map2.put("EMPTY", cnt4);

	     //근태통계 count용
			model.addAttribute("map", map2);
	    }

	    if(deptNo != null) {
	    	model.addAttribute("hiddenDeptNo", deptNo);
	    }

		//현재 날짜도 같이 보내기
		if(month == null || month == "") {
			//month가 널이라면 페이지 처음 요청
			//오늘 날짜를 보낼 것

		   LocalDate now = LocalDate.now();
	       DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
	       String formattedDate = now.format(formatter);

	       log.info("jsp로 보낼 오늘 날짜 : " + formattedDate);

	       model.addAttribute("date", formattedDate);
		}else {
			//month 가 널이아니고 달 정보를 가지고 있다면  ..

		   String formattedMonth = month.substring(0, 4) + "." + month.substring(4, 6);
		   log.info("jsp로 보낼 오늘 날짜 : " + formattedMonth);

		   //monthValue : 현재 달 (202304 -> 4)
		   int monthValue = Integer.parseInt(month.substring(4));

		   model.addAttribute("month", monthValue);

		   //date : ex) 2023.04
		   model.addAttribute("date", formattedMonth);
		}

		return "admin/deptStatisAdmin.admin";
	}


	@ResponseBody
	@PostMapping("/getDeptPerson")
	public Map<String, String> getDeptPerson(@RequestBody Map<String, String> paramMap){

		log.info("deptNo : " + paramMap.get("deptNo"));

		String deptNo = paramMap.get("deptNo");

		Map<String, String> map = new HashMap<String, String>();
		map.put("deptNo", deptNo);

		//처음 페이지 요청 시 전사원 데이터 받아와야함
		if(deptNo == "" || deptNo == null) {
			map  = this.adminWorkService.getDeptPerson();
		}else if(deptNo != null) {
			map  = this.adminWorkService.getDeptPerson2(map);
		}

	    log.info("map (부서 총 인원수)  : " + map);

		return map;
	}

	@ResponseBody
	@PostMapping("/TeamMonthCNT")
	public Map<String, Object> TeamMonthCNT(@RequestBody Map<String,String> parammap){

		log.info("month : " + parammap.get("month"));
		log.info("deptNo : " + parammap.get("deptNo"));
		String deptNo = parammap.get("deptNo");

	    Map<String, String> map = new HashMap<String, String>();

	    map.put("deptNo", parammap.get("deptNo"));
	    map.put("month", parammap.get("month"));

	    Map<String, Object> map2 = new HashMap<String, Object>();

	    //처음 페이지 요청 시 전사원 데이터 받아와야함
		if(deptNo == "" || deptNo == null) {
			map2  = this.adminWorkService.getMonthCNT(map);
		}else if(deptNo != null) {
			map2  = this.workService.TeamMonthCNT(map);
		}

	    log.info("부서별 근태 통계 " + map2);

		return map2;
	}


	@ResponseBody
	@PostMapping("/getDeptInfo")
	public Map<String, Object> getDeptInfo(@RequestBody Map<String,String> parammap){

		log.info("deptNo : " + parammap.get("deptNo"));
		String deptNo = parammap.get("deptNo");

	    Map<String, String> map = new HashMap<String, String>();

	    map.put("deptNo", parammap.get("deptNo"));

	    Map<String, Object> map2 = new HashMap<String, Object>();

	    map2 = this.adminWorkService.getDeptInfo(map);

	    log.info("부서장은?? :  " + map2);

		return map2;
	}


	@GetMapping("/workDeptChart")
	public String workDeptChart(Model model,String month,String deptNo,String deptNm) {
		model.addAttribute("pageMain","AdminChart");
		model.addAttribute("pageDetail","deptStatisAdmin");
		model.addAttribute("pageName","부서별 근태통계");
		
		log.info("month : " + month);
		log.info("deptNo : " + deptNo);


	    Map<String, String> map = new HashMap<String, String>();
	    map.put("month", month);
	    map.put("deptNo", deptNo);

	    model.addAttribute("hiddenDeptNo", deptNo);

	    //month가 null일 경우를 체크해주자
	    //널이면 새로 세팅을 해줘야하고
	    //아니면 부서여부만 체크해서 처리하면되니까

	    // Calendar 객체를 생성하고 Date 객체를 설정합니다.
	    Date todayy = new Date();
	    int mm = todayy.getMonth()+1;  //달
	    int yyyy = todayy.getYear()+1900;  // 년도
	    String mmString = "";
	    int lastdd = 0;

	    if(month == null || month == "") {
			//month가 널이라면 페이지 처음 요청


			Calendar cal = Calendar.getInstance();
			cal.setTime(todayy);

			lastdd = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

			//달에 '0'넣어주기
			if(mm < 10) {
				mmString = String.format("%02d", mm);
			}else{
				mmString = mm+"";
			}

			log.info("처음 페이지 요청시: " + yyyy+mmString);

			map.put("month", yyyy+mmString);

			//처음 페이지 요청시 오늘날짜 기준으로 된 정보 보내기
			//오늘 날짜를 보낼 것
			   LocalDate now = LocalDate.now();
		       DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM");
		       String formattedDate = now.format(formatter);

		       log.info("jsp로 보낼 오늘 날짜 : " + formattedDate);

		       model.addAttribute("date", formattedDate);

		       //해당달의 마지막 날짜 같이 보내기
		       model.addAttribute("hiddenlastDay", lastdd);
	    }



	    	//전체 부서 현재달 count 결과 받기
			Map<String, String> result = this.adminWorkService.getAllWorkCount(map);

			// 조퇴 / 결근 처리
			int cnt2 = Integer.parseInt((String.valueOf(result.get("LATE"))));
			int cnt3 = Integer.parseInt((String.valueOf(result.get("EARLY"))));
			int cnt4 = Integer.parseInt((String.valueOf(result.get("EMPTY"))));;

			cnt3 += Math.floor(cnt2 / 3);  //조퇴
			cnt4 += Math.floor(cnt3 / 3);  //결근

			result.put("EARLY", cnt3+"");
			result.put("EMPTY", cnt4+"");

		  log.info("result(모델로 뿌릴것) : " + result);
		  model.addAttribute("result", result);
		  model.addAttribute("hiddenDeptNm", "전체부서");

	    if(deptNo != null){
	    	//부서정보를 전달받는다면

	    	List<Map<String, String>> result2 = this.adminWorkService.getDeptWorkCount(map);

	    	result2.get(1).get("LATE");

	    	for(int i=0 ; i < result2.size() ; i++) {
	    		// 조퇴 / 결근 처리
	    		int cnt5 = Integer.parseInt((String.valueOf(result2.get(i).get("LATE"))));
	    		int cnt6 = Integer.parseInt((String.valueOf(result2.get(i).get("EARLY"))));
	    		int cnt7 = Integer.parseInt((String.valueOf(result2.get(i).get("EMPTY"))));;

	    		cnt6 += Math.floor(cnt5 / 3);  //조퇴
	    		cnt7 += Math.floor(cnt6 / 3);  //결근

	    		result2.get(i).put("EARLY", cnt6+"");
	    		result2.get(i).put("EMPTY", cnt7+"");
	    	}

			log.info("본부별 근태 현황 : " + result2);

			model.addAttribute("result2", result2);
	    }

	    if(month != null) {
	    	  String formattedMonth = month.substring(0, 4) + "." + month.substring(4, 6);
			   log.info("jsp로 보낼 오늘 날짜 : " + formattedMonth);

			   //monthValue : 현재 달 (202304 -> 4)
			   int monthValue = Integer.parseInt(month.substring(4));


		        YearMonth yearMonth = YearMonth.of(2023,monthValue);  // YearMonth 객체 생성
		        int lastDay = yearMonth.lengthOfMonth();  // 해당 월의 마지막 날짜


			   model.addAttribute("month", monthValue);

			   //date : ex) 2023.04
			   model.addAttribute("date", formattedMonth);

			   //현재달의 마지막 날짜도 같이 보내야됨
			   model.addAttribute("hiddenlastDay", lastDay);

	    }



		return "admin/workDeptChart.admin";
	}

	@GetMapping("/slsChart")
	public String slsChart(Model model) {
		model.addAttribute("pageMain","AdminChart");
		model.addAttribute("pageDetail","slsChart");
		model.addAttribute("pageName","매출통계");

		return "admin/slsChart.admin";
	}


}

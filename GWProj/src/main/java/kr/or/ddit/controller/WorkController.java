package kr.or.ddit.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.WorkService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.Work2VO;
import kr.or.ddit.vo.Work3VO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/work")
@Controller
public class WorkController {
	@Autowired
	WorkService workService;
	
	/**
	 * 요청URI : /getCurrentTime
	 */
	//현재 시각을 json 데이터로 리턴
	@ResponseBody
	@GetMapping("/getCurrentTime")
	public String getCurrentTime() {
		Date day = new Date();
		
		String hour = day.getHours() + "";
		String minute = day.getMinutes() + "";
		String second = day.getSeconds() + "";
		
		if(10-Integer.parseInt(hour) > 0) {
			hour = "0" + hour;
		}
		if(10-Integer.parseInt(minute) > 0) {
			minute = "0" + minute;
		}
		if(10-Integer.parseInt(second) > 0) {
			second = "0" + second;
		}
		
		String CT = hour + ":" + minute + ":" + second;
		
		return CT;
	}
	
	//workList 페이지 요청 시 로그인한 사람의 현재 달의 근태정보를 model에 담아 전달 
	@GetMapping("/workList")
	public String workList(Model model, String month, String dt) {
		model.addAttribute("pageMain","Work");
		model.addAttribute("pageDetail","work List");
		model.addAttribute("pageName","내 근태현황");
		
		
		
		//month : null
		log.info("month : " + month);
		//dt : null
		log.info("dt : " + dt);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		
		EmpVO empVO = principal.getEmpVO();
		
		// 처음 페이지 요청 시 : map : {dt=null, month=null, empNo=202301}
		Map<String, String> map = new HashMap(); 
		map.put("empNo", empVO.getEmpNo()); 
		map.put("month", month); 
		map.put("dt", dt); 
		
		//month가 null이 아닐 때 ex)202304 => 20230401
		if(month != null) {
		String hiddenDate = month+"01"; 
		model.addAttribute("hiddenDate", hiddenDate); 
		}
		
		LocalDate today = LocalDate.now();
		
		
		
		//처음 페이지 요청시 month ex) 202303 / dt => 20230301
		if(month == null) {
		     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
		     String formattedMonth = today.format(formatter);
		     map.put("month",formattedMonth); 
		}
		
		// {dt=null, month=202303, empNo=202301}
		log.info("map(month) : " + map);
		
		//처음 페이지 요청시 dt
		if(dt == null) {
			 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		     String formatteddt = today.format(formatter);
		     map.put("dt",formatteddt);
		}
		//{dt=20230321, month=202303, empNo=202301}
		log.info("map(dt) : " + map);
		
		//해당달의 아코디언 table에 뿌려질 날짜등 근태정보 
	    List<Work2VO> empWorkList = this.workService.getEmpWork(map);
//		List<Work2VO> empWorkList = new ArrayList<Work2VO>();
	    
	    log.info("empWorkList 여기로 나와야함 " + empWorkList);
	    
	    model.addAttribute("data", empWorkList); 
	   
	    // 주별 누적 근무 시간 
	    // 이거 model처리 안되면 아작스로 바꾸기 
	    
	    List<Work2VO> workSumList = this.workService.getWeekSum(map); 
	    log.info("workSumList : " + workSumList);
	    model.addAttribute("workSumList", workSumList); 
		
	    //이번주에 해당하는 누적 근무시간 
	    Date todayy = new Date();
	    int dd = todayy.getDate(); //일자
	    String weekNo;

	    if (dd <= 7) {
	        weekNo = "1";
	    } else if (dd <= 14) {
	        weekNo = "2";
	    } else if (dd <= 21) {
	        weekNo = "3";
	    } else if (dd <= 28) {
	        weekNo = "4";
	    } else {
	        weekNo = "5";
	    }
	    
	    //2월달일 경우
	    String mon = map.get("month");
	    String monthh = mon.substring(4, 6); 
	    log.info("month 02가 나와야해 : " + monthh);
	    log.info("dd는 29가 나와야해  : " + dd);
	    
	    if(monthh.equals("02") && dd > 28) {
	    	weekNo = "4"; 
	    }
	    
	    map.put("weekNo", weekNo); 
	    log.info("파라미터로 넘어갈 값 : " + map.get("dt"));
	    log.info("파라미터로 넘어갈 값 : " + map.get("empNo"));
	    log.info("파라미터로 넘어갈 값 : " + map.get("weekNo"));
	    
	    Work2VO thisWeekSumVO = this.workService.thisWeekSum(map); 
	    
	    log.info("thisWeekSumVO : " + thisWeekSumVO);
	    
	    model.addAttribute("thisWeekSumVO", thisWeekSumVO); 
	    
	    
	    //잔여시간 계산
	    String remainingTime; 
	    
	    if(thisWeekSumVO.getResult().equals("0h 00m 00s")) {
	    	 log.info("여기를 타야함");
	    	 model.addAttribute("thisWeekleft", "0h 00m 00s"); 
	    }else {
	    	log.info("여길 타면 안됨");
	    String timeString = thisWeekSumVO.getResult(); 
	    
	    int hours = Integer.parseInt(timeString.substring(0, timeString.indexOf("h")));
	    int minutes = Integer.parseInt(timeString.substring(timeString.indexOf("m")-2, timeString.indexOf("m")));
	    int seconds = Integer.parseInt(timeString.substring(timeString.indexOf("s")-2, timeString.indexOf("s")));

	    int totalSeconds = hours * 3600 + minutes * 60 + seconds;
	    
	    //52시간 => 187200초
	    int remainingSeconds = 187200 - totalSeconds;

	    int hourss = remainingSeconds / 3600;
	    int minutess = (remainingSeconds % 3600) / 60;
	    int secondss = remainingSeconds % 60;

	    remainingTime = String.format("%02dh %02dm %02ds", hourss, minutess, secondss);
	    
	    log.info("잔여 근무시간 : " + remainingTime);
	    
	    model.addAttribute("thisWeekleft", remainingTime); 
	    }
	    
	    
	  //현재 날짜도 같이 보내기 
  		if(month == null) {
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
		
  		log.info("개똥이6");
		return "work/workList";
	}
	
	@ResponseBody
	@PostMapping("/getWeekTime")
	public Work2VO getWeekTime(){
//		이번주 주간 누적 근무시간 (tiles -> workAside)
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    //파라미터로 보낼 것 (empNo, month, weekNo)
	    map.put("empNo", empVO.getEmpNo()); 
	    
	    LocalDate today = LocalDate.now();
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
	    String formattedMonth = today.format(formatter);
	    map.put("month",formattedMonth); 
	    
	    Date todayy = new Date();
	    int dd = todayy.getDate(); //일자
	    String weekNo;

	    if (dd <= 7) {
	        weekNo = "1";
	    } else if (dd <= 14) {
	        weekNo = "2";
	    } else if (dd <= 21) {
	        weekNo = "3";
	    } else if (dd <= 28) {
	        weekNo = "4";
	    } else {
	        weekNo = "5";
	    }
	    
	    map.put("weekNo", weekNo); 
	    
		Work2VO vo = this.workService.thisWeekSum(map); 
		
		log.info("타일즈 누적근무시간 : " + vo); 
		
		return vo;
	}
	
	
	@GetMapping("/holyList")
	public String holyList(Model model) {
		model.addAttribute("pageMain","Work");
		model.addAttribute("pageDetail","annual List");
		model.addAttribute("pageName","내 연차내역");
		
		return "work/holyList";
	}
	
	@GetMapping("/empDetail")
	public String empDetail(Model model) {
		model.addAttribute("pageMain","Work");
		model.addAttribute("pageDetail","personal record");
		model.addAttribute("pageName","내 인사정보");
		
		return "work/empDetail";
	}
	
	@GetMapping("/deptWorkList")
	public String deptWorkList(Model model,String year, String month, String weekno, String lastday) {
		model.addAttribute("pageMain","Work");
		model.addAttribute("pageDetail","deptWork List");
		model.addAttribute("pageName","부서 근태현황");
		
		log.info("파라미터 year : " + year ); //'yyyy'로 바꿔줘야함 
		log.info("파라미터 month : " + month ); //'mmString'
		log.info("파라미터 weekno : " + weekno ); //'weekNo'로 변환 
		
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("deptNo", empVO.getDeptNo()); 
		
		//시작날짜 
		String bgng; 
		
		//끝 날짜 
		String end; 
		
		//오늘날짜가 해당하는 주차를 알아야함 
		Date todayy = new Date();
		    int dd = todayy.getDate(); //일자
		    int mm = todayy.getMonth()+1;  //달
		    int yyyy = todayy.getYear()+1900;  // 년도 
		    String mmString = ""; 
		    String weekNo ="";
		    int lastdd = 0;
		    
		    log.info("yyyy : " + yyyy);
		    log.info("mm : " + mm);
		    log.info("dd : " + dd);
		
		 //처음 페이지 요청 시 
		if(month == null) {
			// Calendar 객체를 생성하고 Date 객체를 설정합니다.
			Calendar cal = Calendar.getInstance();
			cal.setTime(todayy);
			
			// 현재 월의 마지막 날짜를 가져옵니다.
			lastdd = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			
			//달에 '0'넣어주기 
			if(mm < 10) {
				mmString = String.format("%02d", mm);
			}else{
				mmString = mm+""; 
			}
			
			log.info("mm (0이붙음): " + mmString);

			//주차 찾아내기
			if (dd <= 7) {
				weekNo = "1";
			} else if (dd <= 14) {
				weekNo = "2";
			} else if (dd <= 21) {
				weekNo = "3";
			} else if (dd <= 28) {
				weekNo = "4";
			} else {
				weekNo = "5";
			}
			
		}
		
		//만약 파라미터가 들어왔을 때는 
		if(year != null && month != null && weekNo != null && lastday != null) {
			log.info("여길 타야해!!!!!!!!!!!!!");
			yyyy = Integer.parseInt(year);
			mmString = month; 
			
			if (weekno.equals("1")) {
				weekNo = "1";
			} else if (weekno.equals("2")) {
				weekNo = "2";
			} else if (weekno.equals("3")) {
				weekNo = "3";
			} else if (weekno.equals("4")) {
				weekNo = "4";
			} else {
				weekNo = "5";
			}
			
			lastdd = Integer.parseInt(lastday); 
		}
		
		log.info("파라미터가 들어오면 weekNo = 4 : " +weekNo);
		
		//주차별 시작날짜와 종료날짜를 만듬 
		    if (weekNo == "1") {
		    	bgng = yyyy+mmString+"01";   
		    	end = yyyy+mmString+"07";  
		    	map.put("day1", "01");
		    	map.put("day2", "02");
		    	map.put("day3", "03");
		    	map.put("day4", "04");
		    	map.put("day5", "05");
		    	map.put("day6", "06");
		    	map.put("day7", "07");
		    	
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }else if(weekNo == "2") {
		       	map.put("day1", "08");
		    	map.put("day2", "09");
		    	map.put("day3", "10");
		    	map.put("day4", "11");
		    	map.put("day5", "12");
		    	map.put("day6", "13");
		    	map.put("day7", "14");
		    	
		    	bgng = yyyy+mmString+"08";   
		    	end = yyyy+mmString+"14"; 
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    	
		    }else if(weekNo == "3") {
		      	map.put("day1", "15");
		    	map.put("day2", "16");
		    	map.put("day3", "17");
		    	map.put("day4", "18");
		    	map.put("day5", "19");
		    	map.put("day6", "20");
		    	map.put("day7", "21");
		    	
		    	bgng = yyyy+mmString+"15";   
		    	end = yyyy+mmString+"21"; 
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }else if(weekNo == "4") {
		    	map.put("day1", "22");
		    	map.put("day2", "23");
		    	map.put("day3", "24");
		    	map.put("day4", "25");
		    	map.put("day5", "26");
		    	map.put("day6", "27");
		    	map.put("day7", "28");
		    	
		    	bgng = yyyy+mmString+"22";   
		    	end = yyyy+mmString+"28";   
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }else {
		    	//반복문 
		    	int cnt = 1; 
		    	for(int i=29; i <= lastdd ; i++) {
		    		String day = "day"+cnt;
			    	map.put(day, ""+i+"");
			    	
			    	cnt+=1; 
		    	}
		    	
		    	map.put("day4", "00"); 
		    	map.put("day5", "00"); 
	    		map.put("day6", "00"); 
	    		map.put("day7", "00"); 
		    	
		    	if(lastdd == 30) {
		    		map.put("day3", "00"); 
		    	}
		    	
		    	bgng = yyyy+mmString+"29";   
		    	end = yyyy+mmString+lastdd+"";   
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }
		    
		    
		// 서비스 호출 
		  List<Work3VO> workList = this.workService.getDeptWeek(map); 
		   
		  log.info("부서 근태현황 나와라잇 : " + workList);
		  
		  // 부서 근태 현황 리스트 
		  model.addAttribute("workList", workList); 
		  
		//모델로 보낼 때 년 + 월도 같이 보내기 
		  model.addAttribute("year", yyyy); 
		  model.addAttribute("month", mmString); 
		  
		// 모델로 보낼 때 주차를 같이 보내야함  (2023.03.22 ~ 2023.03.28) 
		  model.addAttribute("weekNo", weekNo); 
		
		return "work/deptWorkList";
	}
	
	@GetMapping("/deptStatis")
	public String deptStatis(Model model,String month) {
		model.addAttribute("pageMain","Work");
		model.addAttribute("pageDetail","dept statistics");
		model.addAttribute("pageName","부서 근태통계");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("deptNo", empVO.getDeptNo()); 
	    map.put("month", month); 
	    
		List<WorkVO> workList = this.workService.getDeptWork(map);
		
		Map<String, Object> map2  = new HashMap<String, Object>(); 
		
		map2  = this.workService.TeamMonth(map);
		
		// 지각3번(지각수/3으로 나눈 몫을 조퇴에 +1) => 조퇴 +1
		// 조퇴3번(조퇴수/3으로 나눈 몫을 결근에 +1) => 결근 +1
			
			int cnt2 = Integer.parseInt((String.valueOf(map2.get("LATE")))); 
			int cnt3 = Integer.parseInt((String.valueOf(map2.get("EARLY")))); 
			int cnt4 = Integer.parseInt((String.valueOf(map2.get("EMPTY"))));;  
			
			cnt3 += Math.floor(cnt2 / 3);  //조퇴 
			cnt4 += Math.floor(cnt3 / 3);  //결근 
			
			map2.put("EARLY", cnt3); 
			map2.put("EMPTY", cnt4); 
		
		log.info("잘 나옴? workList : " +workList);
		log.info("잘 나옴? map : " + map2 );
		
		
		model.addAttribute("workList", workList); 
		
		//근태통계 count용 
		model.addAttribute("map", map2); 
		
		
		//현재 날짜도 같이 보내기 
		if(month == null) {
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
		
		return "work/deptStatis";
	}
	
	@ResponseBody
	@PostMapping("/getHoliInfo")
	public List<Map<String, Object>> getHoliInfo(){
		//연차 정보 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    List<Map<String, Object>> result = this.workService.getHoliInfo(empVO);
		
		
		log.info("연차 리스트 : " + result); 
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/deptWorkSearch")
	public List<Work3VO> deptWorkSearch(@RequestBody Map<String,String> workMap){
		//부서근태현황페이지에서 검색버튼 눌렀을 때 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("deptNo", empVO.getDeptNo()); 
		
		//시작날짜 
		String bgng; 
		
		//끝 날짜 
		String end; 
		
		//오늘날짜가 해당하는 주차를 알아야함 
		Date todayy = new Date();
		    int dd = todayy.getDate(); //일자
		    int mm = todayy.getMonth()+1;  //달
		    int yyyy = todayy.getYear()+1900;  // 년도 
		    String mmString = ""; 
		    String weekNo ="";
		    int lastdd = 0;
		    
			yyyy = Integer.parseInt(workMap.get("year"));
			mmString = workMap.get("month"); 
			
			if (workMap.get("weekno").equals("1")) {
				weekNo = "1";
			} else if (workMap.get("weekno").equals("2")) {
				weekNo = "2";
			} else if (workMap.get("weekno").equals("3")) {
				weekNo = "3";
			} else if (workMap.get("weekno").equals("4")) {
				weekNo = "4";
			} else {
				weekNo = "5";
			}
			
			lastdd = Integer.parseInt(workMap.get("lastday")); 
		
		//주차별 시작날짜와 종료날짜를 만듬 
		    if (weekNo == "1") {
		    	bgng = yyyy+mmString+"01";   
		    	end = yyyy+mmString+"07";  
		    	map.put("day1", "01");
		    	map.put("day2", "02");
		    	map.put("day3", "03");
		    	map.put("day4", "04");
		    	map.put("day5", "05");
		    	map.put("day6", "06");
		    	map.put("day7", "07");
		    	
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }else if(weekNo == "2") {
		       	map.put("day1", "08");
		    	map.put("day2", "09");
		    	map.put("day3", "10");
		    	map.put("day4", "11");
		    	map.put("day5", "12");
		    	map.put("day6", "13");
		    	map.put("day7", "14");
		    	
		    	bgng = yyyy+mmString+"08";   
		    	end = yyyy+mmString+"14"; 
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    	
		    }else if(weekNo == "3") {
		      	map.put("day1", "15");
		    	map.put("day2", "16");
		    	map.put("day3", "17");
		    	map.put("day4", "18");
		    	map.put("day5", "19");
		    	map.put("day6", "20");
		    	map.put("day7", "21");
		    	
		    	bgng = yyyy+mmString+"15";   
		    	end = yyyy+mmString+"21"; 
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }else if(weekNo == "4") {
		    	map.put("day1", "22");
		    	map.put("day2", "23");
		    	map.put("day3", "24");
		    	map.put("day4", "25");
		    	map.put("day5", "26");
		    	map.put("day6", "27");
		    	map.put("day7", "28");
		    	
		    	bgng = yyyy+mmString+"22";   
		    	end = yyyy+mmString+"28";   
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }else {
		    	//반복문 
		    	int cnt = 1; 
		    	for(int i=29; i <= lastdd ; i++) {
		    		String day = "day"+cnt;
			    	map.put(day, ""+i+"");
			    	
			    	cnt+=1; 
		    	}
		    	
		    	map.put("day4", "00"); 
		    	map.put("day5", "00"); 
	    		map.put("day6", "00"); 
	    		map.put("day7", "00"); 
		    	
		    	if(lastdd == 30) {
		    		map.put("day3", "00"); 
		    	}
		    	
		    	bgng = yyyy+mmString+"29";   
		    	end = yyyy+mmString+lastdd+"";   
		    	map.put("bgng", bgng);
		    	map.put("end", end);
		    }
		    
		//검색하려면 검색숫자와 초과/미만 
		   map.put("num", workMap.get("number")); 
		   map.put("choice", workMap.get("choice")); 
		    
		// 서비스 호출 
		  List<Work3VO> workList = this.workService.deptWorkSearch(map); 
		  log.info("검색 결과 리스트!!! : " + workList);
		
		return workList;
	}
	
	
	@ResponseBody
	@PostMapping("/insertgw")
	public EmpVO insertgw(){
//		출근 버튼을 누르면 근태관리테이블의 출근 시간이 insert됨 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
		int result = this.workService.insertgw(empVO);
		
		
		log.info("출근버튼누르고서 근무상세를 받아와야함" + empVO); 
		
		return empVO;
	}
	
	@ResponseBody
	@PostMapping("/pptGoWork")
	public EmpVO pptGoWork(){
//		시연용 출근 버튼 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
		int result = this.workService.pptGoWork(empVO);
		
		
		log.info("출근버튼누르고서 근무상세를 받아와야함" + empVO); 
		
		return empVO;
	}
	
	
	
	@ResponseBody
	@PostMapping("/insertgh")
	public int insertgh(){
//		출근 버튼을 누르면 근태관리테이블의 퇴근 시간 및 근무상세등이 update됨 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
		int result = this.workService.insertgh(empVO);
		
		
		
		log.info("result : " + result);
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/pptGoHome")
	public int pptGoHome(){
//		출근 버튼을 누르면 근태관리테이블의 퇴근 시간 및 근무상세등이 update됨 
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
		int result = this.workService.pptGoHome(empVO);
		
		
		
		log.info("result : " + result);
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/updateSsts")
	public int updateSsts(@RequestBody Map<String,String> workMap){
		log.info("workMap : " + workMap);
		
		WorkVO workVO = new WorkVO();
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
		workVO.setEmpNo(empVO.getEmpNo());
		workVO.setWorkMngSsts(workMap.get("workMngSsts"));
		
		int result = this.workService.updateSsts(workVO); 
		
		log.info("result : " + result);
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("/selectTime")
	public EmpVO selectTime(){
//		출근/퇴근/근무상태 정보를 가져오는 VO
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
		empVO = this.workService.selectTime(empVO);
		
		
		return empVO;
	}
	
	
	@ResponseBody
	@PostMapping("/countWork")
	public WorkVO countWork(){
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    WorkVO workVO = new WorkVO(); 
	    workVO.setEmpNo(empVO.getEmpNo());
	    
	    WorkVO workvo = this.workService.countWork(workVO); 
		
		log.info("퇴근시간을 널로 체크 : "+workvo);
		return workvo;
	}
	
	@ResponseBody
	@PostMapping("/getTeam")
	public EmpVO getTeam(){
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    
	    EmpVO empvo = this.workService.getTeam(empVO); 
		
		log.info("empvo "+empvo);
		return empvo;
	}
	
	@ResponseBody
	@PostMapping("/getMonthWT")
	public WorkVO getMonthWT(@RequestBody Map<String,String> parammap){
		
		log.info("month : " + parammap.get("month"));
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("empNo", empVO.getEmpNo()); 
	    map.put("month", parammap.get("month")); 
		
	    WorkVO workVO  = this.workService.getMonthWT(map); 
		
	    if(workVO.getResult().equals("h m s")) {
	    	workVO.setResult("0h 00m 00s");
	    }
	    
	    
	    log.info("왜 안나와!!!!!!!!" + workVO);
	    
		
		return workVO;
	}
	
	
	@ResponseBody
	@PostMapping("/getMonthCNT")
	public Map<String, String> getMonthCNT(@RequestBody Map<String,String> parammap){
		
		log.info("month : " + parammap.get("month"));
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("empNo", empVO.getEmpNo()); 
	    map.put("month", parammap.get("month")); 
		
	    map  = this.workService.getMonthCNT(map); 
		
	    log.info("맵으로 결과를 받아올 수 있을까요" + map);
		
		return map;
	}
	
	
	@ResponseBody
	@PostMapping("/getDeptPerson")
	public Map<String, String> getDeptPerson(){
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("deptNo", empVO.getDeptNo()); 
		
	    map  = this.workService.getDeptPerson(map); 
		
	    log.info("map (부서 총 인원수)  : " + map);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/TeamMonthCNT")
	public Map<String, Object> TeamMonthCNT(@RequestBody Map<String,String> parammap){
		
		log.info("month : " + parammap.get("month"));
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();

	    EmpVO empVO = principal.getEmpVO();
	    
	    Map<String, String> map = new HashMap<String, String>(); 
	    
	    map.put("deptNo", empVO.getDeptNo()); 
	    map.put("month", parammap.get("month")); 
		
	    Map<String, Object> map2 = new HashMap<String, Object>(); 
	    map2  = this.workService.TeamMonthCNT(map); 
		
	    log.info("부서별 근태 통계 " + map2);
		
		return map2;
	}
	

	
}

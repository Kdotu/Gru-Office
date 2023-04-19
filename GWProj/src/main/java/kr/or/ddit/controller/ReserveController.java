package kr.or.ddit.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.ReserveService;
import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.CalVO;
import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MtgrmVO;
import kr.or.ddit.vo.RoomRsvtVO;
import kr.or.ddit.vo.VhrRsvtVO;
import kr.or.ddit.vo.VhrVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve")
public class ReserveController {

	@Autowired
	ReserveService reserveService;

	/**
	 * 차량예약 페이지 리턴
	 * @param model
	 * @return "reservations/car";
	 */
	@GetMapping("/car")//차량예약 페이지
	public String getVhrList(Model model) {
		model.addAttribute("pageMain","Reservation");
		model.addAttribute("pageDetail","car");
		model.addAttribute("pageName","차량 예약");

		List<VhrVO> vhrVOList = reserveService.getAllVhr();
		model.addAttribute("vhrVOList",vhrVOList);

		return "reservations/car";
	}

	/**
	 * 차량예약상세 페이지 리턴
	 * @param vhrNo
	 * @param model
	 * @return "reservations/carDetail";
	 * @throws JsonProcessingException
	 */
	@PostMapping("/carDet")
	public String reserveCarDetail(@RequestParam("vhrNo") String vhrNo, Model model) throws JsonProcessingException {

		model.addAttribute("pageMain","Reservation");
		model.addAttribute("pageDetail","car Detail");
		model.addAttribute("pageName","차량 상세");

		VhrVO vhrVO = new VhrVO();
		vhrVO.setVhrNo(vhrNo);

		vhrVO = reserveService.getVhr(vhrVO);
		model.addAttribute("vhrVO" , vhrVO);

		List<VhrRsvtVO> vhrRsvtVOList = reserveService.getCarReserve(vhrVO);

		// jackson objectmapper 객체 생성
		ObjectMapper mapper = new ObjectMapper();

		String vhrRsvtVOListString =  mapper.writeValueAsString(vhrRsvtVOList);
		log.info("getCal : " + vhrRsvtVOListString);

		model.addAttribute("vhrRsvtVOListString", vhrRsvtVOListString);

		return "reservations/carDetail";
	}
	
	/**
	 * 회의실예약 페이지 리턴. 만약 myDate를 받으면 받은 myDate로,
	 * 아닌 경우에는 오늘날짜로 일정 검색 후 일정목록을 리턴함
	 * @param myDate
	 * @param model
	 * @return "reservations/room2";
	 */
	@GetMapping("/room")//
	public String reserveRoom(String myDate, Model model) {
		log.info("myDate : " + myDate);
		
		//일단 오늘날짜 생성해서 String타입으로 만들어둠. today에 저장
		DateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date nowDate = new Date();
		String today = sdFormat.format(nowDate);
		log.info("현재 날짜 확인 : " + today);
		
		//만약 myDate를 받았는데 myDate가 널이 아니고, myDate와 today가 같지 않으면
		if(myDate != null && !myDate.equals(today)) {
			//today를 myDate로 바꿈
			today = myDate;
			log.info("다르다!");
		}
		log.info("바뀐 시간 확인 : " + today);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();

		EmpVO empVO = principal.getEmpVO();

		String empNm = empVO.getEmpNm();
		String empNo = empVO.getEmpNo();

		List<MtgrmVO> mtgrmVOList = reserveService.getMtgrm();
		List<RoomRsvtVO> roomRsvtVOList = reserveService.getAllresRoomForDay(today);

		log.info("roomRsvtVOList 확인" + roomRsvtVOList);

		model.addAttribute("empNm", empNm);
		model.addAttribute("empNo", empNo);
		model.addAttribute("mtgrmVOList", mtgrmVOList);
		model.addAttribute("roomRsvtVOList", roomRsvtVOList);
		model.addAttribute("pageMain","Reservation");
		model.addAttribute("pageDetail","Meeting room");
		model.addAttribute("pageName","회의실 예약");
		model.addAttribute("today", today);

		return "reservations/room2";
	}

	/**
	 * 내 예약목록 페이지 리턴
	 * @param model
	 * @return "reservations/myReserve";
	 */
	@GetMapping("/myres")
	public String getMyresRoom(Model model) {
		model.addAttribute("pageMain","Reservation");
		model.addAttribute("pageDetail","my Reservation");
		model.addAttribute("pageName","예약 현황");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();

		EmpVO empVO = principal.getEmpVO();

		String empNo = empVO.getEmpNo();
		// 회의실 예약목록 불러오기
		RoomRsvtVO roomRsvtVO = new RoomRsvtVO();
		roomRsvtVO.setEmpNo(empNo);

		List<RoomRsvtVO> roomRsvtVOList = reserveService.getMyresRoom(roomRsvtVO);

		//차량 예약목록 불러오기
		VhrRsvtVO vhrRsvtVO = new VhrRsvtVO();
		vhrRsvtVO.setEmpNo(empNo);

		List<VhrRsvtVO> vhrRsvtVOList = reserveService.getMyresVhr(vhrRsvtVO);

		model.addAttribute("roomRsvtVOList", roomRsvtVOList);
		model.addAttribute("vhrRsvtVOList", vhrRsvtVOList);

		return "reservations/myReserve";
	}

	/**
	 * 회의실예약 삭제 실행 후 삭제가 적용된 테이블의 행 수 리턴
	 * @param roomRsvtVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteRoomRes")// 
	public int deleteRoomRes(@RequestBody RoomRsvtVO roomRsvtVO) throws Exception {
			log.info("예약 삭제시 roomRsvtVO : " + roomRsvtVO);
		    int result = reserveService.deleteRoomRes(roomRsvtVO);
		    return result;
	}

	/**
	 * 차량 예약삭제 실행 후 삭제가 적용된 테이블의 행 수 리턴
	 * @param vhrRsvtVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteCarRes")
	public int deleteCarRes(@RequestBody VhrRsvtVO vhrRsvtVO) throws Exception {
		log.info("예약 삭제시 vhrRsvtVO : " + vhrRsvtVO);
		int result = reserveService.deleteCarRes(vhrRsvtVO);
		return result;
	}

	/**
	 * 차량 예약상태 변경 실행 후 수정이 적용된 테이블의 행 수 리턴
	 * @param vhrRsvtVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/updateCarRes") 
	public int updateCarRes(@RequestBody VhrRsvtVO vhrRsvtVO) throws Exception {
		log.info("예약 상태 변경시 vhrRsvtVO : " + vhrRsvtVO);
		int result = reserveService.updateCarRes(vhrRsvtVO);
		return result;
	}

	/**
	 * 차량예약 실행 후 새로 생성된 테이블의 행수 리턴
	 * @param vhrRsvtVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/createCarReserve")
	public int createCarReserve(@RequestBody VhrRsvtVO vhrRsvtVO) throws Exception {
		log.info("새 차량 예약 생성시 vhrRsvtVO : " + vhrRsvtVO);
		int result = reserveService.createCarReserve(vhrRsvtVO);
		return result;
	}
	
	/**
	 * 회의실예약 실행 후 새로 생성된 테이블의 행수 리턴
	 * @param roomRsvtVO
	 * @return result
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/createRoomReserve")//
	public int createRoomReserve(@RequestBody RoomRsvtVO roomRsvtVO) throws Exception {
		log.info("새 회의실 예약 생성시 roomRsvtVO : " + roomRsvtVO);
		int result = reserveService.createRoomReserve(roomRsvtVO);
		return result;
	}

}

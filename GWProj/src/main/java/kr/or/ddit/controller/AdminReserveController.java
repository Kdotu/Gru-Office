package kr.or.ddit.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.ReserveService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MtgrmVO;
import kr.or.ddit.vo.RoomRsvtVO;
import kr.or.ddit.vo.VhrRsvtVO;
import kr.or.ddit.vo.VhrVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminReserveController {

	@Autowired
	ReserveService reserveService;
	
	@Autowired
	FileService fileService;

	/**
	 * vhrVOList와  mtgrmVOList를 가져와서 표로 출력하기 위한 메서드.
	 * 자원관리 페이지의 차량정보와 회의실 정보를 가져옴
	 * @param model
	 * @return "admin/reserveMain.admin";
	 */
	@GetMapping("/reserveMain")
	public String reserveMain(Model model) {

		List<VhrVO> vhrVOList = reserveService.getAllVhr();
		List<MtgrmVO> mtgrmVOList = reserveService.getMtgrm();
		model.addAttribute("vhrVOList" , vhrVOList);
		model.addAttribute("mtgrmVOList" , mtgrmVOList);
		
		model.addAttribute("pageMain","AdminReserve");
		model.addAttribute("pageDetail","resourceManagement");
		model.addAttribute("pageName","자원 관리");
		
		return "admin/reserveMain.admin";
	}

	/**
	 * 새로운 차량목록 생성
	 * @param vhrVO
	 * @return "redirect:/admin/reserveMain";
	 */
	@PostMapping("/createCar")
	public String createCar(VhrVO vhrVO) {
		String vhrNo =  reserveService.getVhrNo();
		log.info("vhrNo 확인  "+vhrNo);
		vhrVO.setVhrNo(vhrNo);
		
		if(vhrVO.getUploadFile() != null) {
			int result2 = fileService.vhrFileCreate(vhrVO);
		}
		int result = reserveService.createCar(vhrVO);
		
		return "redirect:/admin/reserveMain";
	}

	/**
	 * 차량 삭제
	 * @param vhrVO
	 * @return "redirect:/admin/reserveMain";
	 */
	@RequestMapping(value="/updateCar", method=RequestMethod.POST)
	public String updateCar(VhrVO vhrVO) {

		log.info("차량 삭제 시 vhrVO : " + vhrVO);

		int result = reserveService.updateCar(vhrVO);

		return "redirect:/admin/reserveMain";
	}

	/**
	 * 새로운 회의실 생성
	 * @param mtgrmInfo
	 * @param mtgrmAvarPeo
	 * @param mtgrmProj
	 * @param mtgrmBo
	 * @param mtgrmPc
	 * @param mtgrmAir
	 * @return "redirect:/admin/reserveMain";
	 */
	@RequestMapping(value="/createRoom", method=RequestMethod.POST)
	public String createRoom(@RequestParam("mtgrmInfo") String mtgrmInfo, @RequestParam("mtgrmAvarPeo") int mtgrmAvarPeo,
			@RequestParam("mtgrmProj") int mtgrmProj, @RequestParam("mtgrmBo") int mtgrmBo,
			@RequestParam("mtgrmPc") int mtgrmPc, @RequestParam("mtgrmAir") int mtgrmAir) {
		MtgrmVO mtgrmVO = new MtgrmVO();
		mtgrmVO.setMtgrmInfo(mtgrmInfo);
		mtgrmVO.setMtgrmAvarPeo(mtgrmAvarPeo);
		mtgrmVO.setMtgrmProj(mtgrmProj);
		mtgrmVO.setMtgrmBo(mtgrmBo);
		mtgrmVO.setMtgrmPc(mtgrmPc);
		mtgrmVO.setMtgrmAir(mtgrmAir);

		int result = reserveService.createRoom(mtgrmVO);

		return "redirect:/admin/reserveMain";
	}

	/**
	 * 회의실 정보 수정
	 * @param mtgrmNo
	 * @param mtgrmInfo
	 * @param mtgrmAvarPeo
	 * @param mtgrmProj
	 * @param mtgrmBo
	 * @param mtgrmPc
	 * @param mtgrmAir
	 * @param mtgrmAvalYn
	 * @return "redirect:/admin/reserveMain";
	 */
	@RequestMapping(value="/updateRoom", method=RequestMethod.POST)
	public String updateRoom(@RequestParam("mtgrmNo") String mtgrmNo, @RequestParam("mtgrmInfo") String mtgrmInfo,
							 @RequestParam("mtgrmAvarPeo") int mtgrmAvarPeo, @RequestParam("mtgrmProj") int mtgrmProj,
							 @RequestParam("mtgrmBo") int mtgrmBo, @RequestParam("mtgrmPc") int mtgrmPc,
							 @RequestParam("mtgrmAir") int mtgrmAir, @RequestParam("mtgrmAvalYn") String mtgrmAvalYn) {

		MtgrmVO mtgrmVO = new MtgrmVO();
		mtgrmVO.setMtgrmNo(mtgrmNo);
		mtgrmVO.setMtgrmInfo(mtgrmInfo);
		mtgrmVO.setMtgrmAvarPeo(mtgrmAvarPeo);
		mtgrmVO.setMtgrmProj(mtgrmProj);
		mtgrmVO.setMtgrmBo(mtgrmBo);
		mtgrmVO.setMtgrmPc(mtgrmPc);
		mtgrmVO.setMtgrmAir(mtgrmAir);
		mtgrmVO.setMtgrmAvalYn(mtgrmAvalYn);

		int result = reserveService.updateRoom(mtgrmVO);

		return "redirect:/admin/reserveMain";
	}

	/**
	 * 회의실 삭제
	 * @param mtgrmVO
	 * @return "redirect:/admin/reserveMain";
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteRoom")
	public String deleteRoom(@RequestBody MtgrmVO mtgrmVO) throws Exception {
		log.info("회의실 삭제 시 mtgrmVO : " + mtgrmVO);

		int result = reserveService.deleteRoom(mtgrmVO);
		return "redirect:/admin/reserveMain";
	}

	/**
	 * 차량 삭제
	 * @param vhrVO
	 * @return "redirect:/admin/reserveMain";
	 * @throws Exception
	 */
	@ResponseBody
	@PostMapping("/deleteCar")
	public String deleteCar(@RequestBody VhrVO vhrVO) throws Exception {
		log.info("차량 삭제 시 vhrVO : " + vhrVO);

		int result = reserveService.deleteCar(vhrVO);
		return "redirect:/admin/reserveMain";
	}

	/**
	 * 회의실 및 차량의 전체 예약목록과 미반납 차량목록을 불러옴
	 * @param model
	 * @return "admin/reserveList.admin";
	 */
	@GetMapping("/reserveList")//전체 예약목록
	public String reserveList(Model model) {
		model.addAttribute("pageMain","AdminReserve");
		model.addAttribute("pageDetail","reserveList");
		model.addAttribute("pageName","예약목록");
		
		// 회의실 예약목록 불러오기
		List<RoomRsvtVO> roomRsvtVOList = reserveService.getAllMyresRoom();

		//차량 예약목록 불러오기
		List<VhrRsvtVO> vhrRsvtVOList = reserveService.getAllMyresVhr();
		
		List<VhrRsvtVO> vhrNotReturnRsvtVOList = reserveService.getNotReturnMyresVhr();

		
		model.addAttribute("roomRsvtVOList", roomRsvtVOList);
		model.addAttribute("vhrRsvtVOList", vhrRsvtVOList);
		model.addAttribute("vhrNotReturnRsvtVOList", vhrNotReturnRsvtVOList);

		return "admin/reserveList.admin";
	}

	/**
	 * 관리자용 차량 예약페이지 리턴
	 * @param model
	 * @return "admin/car.admin";
	 */
	@GetMapping("/car")//차량예약 페이지
	public String getVhrList(Model model) {
		model.addAttribute("pageMain","Reservation");
		model.addAttribute("pageDetail","car");
		model.addAttribute("pageName","차량 예약");

		List<VhrVO> vhrVOList = reserveService.getAllVhr();
		model.addAttribute("vhrVOList",vhrVOList);

		return "admin/car.admin";
	}
	
	/**
	 * 관리자용 차량예약 상세 페이지 리턴
	 * @param vhrNo
	 * @param model
	 * @return "admin/carDetail.admin";
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

		return "admin/carDetail.admin";
	}
	
	/**
	 * 관리자용 회의실 예약 페이지
	 * @param myDate
	 * @param model
	 * @return "admin/room2.admin";
	 */
	@GetMapping("/room")
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

		//각종 정보 정리해서 보냄
		model.addAttribute("empNm", empNm);
		model.addAttribute("empNo", empNo);
		model.addAttribute("mtgrmVOList", mtgrmVOList);
		model.addAttribute("roomRsvtVOList", roomRsvtVOList);
		model.addAttribute("pageMain","Reservation");
		model.addAttribute("pageDetail","Meeting room");
		model.addAttribute("pageName","회의실 예약");
		model.addAttribute("today", today);

		return "admin/room2.admin";
	}


}

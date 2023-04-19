package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.NoteService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.NoteVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/note")
public class NoteConteroller {

	@Autowired
	NoteService noteService;

	//받은쪽지함 목록 조회
	@GetMapping("/recieveList")
	public String recieveList(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "받은쪽지함");
		log.info("noteVO : " + noteVO);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();

		noteVO.setEmpNoRcvr(username);
		log.info("noteVO : " + noteVO);

		List<NoteVO> recieveNtList = noteService.recieveNtList(noteVO);
		log.info("recieveNtList: " + recieveNtList);

		model.addAttribute("data", recieveNtList);

		return "note/recieveList";
	}

	//보낸쪽지함 목록 조회
	@GetMapping("/send")
	public String send(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "보낸쪽지함");

		log.info("noteVO : " + noteVO);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();

		noteVO.setEmpNoSndpty(username);
		log.info("noteVO : " + noteVO);

		List<NoteVO> sendNtList = noteService.sendNtList(noteVO);
		log.info("recieveNtList: " + sendNtList);

		model.addAttribute("data", sendNtList);


		return "note/send";
	}

	//쪽지보관함 목록 조회
	@GetMapping("/keep")
	public String keep(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "쪽지보관함");

		log.info("noteVO : " + noteVO);

		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();	
		
		noteVO.setEmpNoSndpty(empVO.getEmpNo());		
		noteVO.setEmpNoRcvr(empVO.getEmpNo());	
		
		log.info("noteVO 들왔?" +noteVO);

		List<NoteVO> keepNtList = noteService.keepNtList(noteVO);
		log.info("recieveNtList: " + keepNtList);

		model.addAttribute("data", keepNtList);

		return "note/keep";
	}

	//쪽지상세보기
	@GetMapping("/detail")
	public String detail(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "쪽지상세");

		log.info(">>>noteVO : " + noteVO);

		NoteVO data = noteService.noteDetail(noteVO);
		log.info(">>>data : " + data);

		model.addAttribute("data",data);

		return "note/detail";
	}

//	@GetMapping("/keepDetail")
//	public String keepDetail(Model model, @ModelAttribute NoteVO noteVO) {
//		model.addAttribute("pageMain", "My Page");
//		model.addAttribute("pageDetail", "note");
//		model.addAttribute("pageName", "쪽지상세");
//
//		log.info(">>>noteVO : " + noteVO);
//
//		NoteVO data = noteService.noteDetail(noteVO);
//		log.info(">>>data : " + data);
//
//		model.addAttribute("data",data);
//
//		return "note/detail";
//	}

	//받은(임시)쪽지 상세보기
	@GetMapping("/rcvNtDetail")
	public String rcvDetail(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "쪽지상세");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();

		noteVO.setEmpNoRcvr(username);
		
		//oteVO 바바2 : NoteVO(msgNo=MSG0017, empNoSndpty=202301, sender=조현준 <-이거 안바뀜..
//		noteVO.setSender(null);

		log.info(">>>noteVO : " + noteVO);
		NoteVO rcvNtDetail = noteService.rcvNtDetail(noteVO);
		log.info("rcvNtDetail : " + rcvNtDetail);

		model.addAttribute("data",rcvNtDetail);

		return "note/rcvDetail";
	}

	//쪽지 쓰기
	@GetMapping("/write")
	public String write(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "쪽지작성");

		return "note/write";
	}

	//쪽지쓰면 오는곳
	@PostMapping("/writePost")
	public String writePost(@ModelAttribute NoteVO noteVO) {
		log.info("noteVO : " + noteVO);
		log.info("1");
		if (noteVO.getMsgCateTag() == null || noteVO.getMsgCateTag().equals("")) {
			noteVO.setMsgCateTag("일반");
		} else {
			noteVO.setMsgCateTag("긴급");
		}
		log.info("2");
//		if(noteVO.getMsgClsfNo() == null || noteVO.getMsgClsfNo().equals("")) {
//			noteVO.setMsgClsfNo("MSGT0001");
//		}
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();
		log.info("3");

		noteVO.setEmpNoSndpty(username);
		log.info("noteVOLog : " + noteVO);

		int result = noteService.writeNote(noteVO);

		log.info("noteVO2 : " + noteVO);
		log.info("result : " + result);

		return "redirect:/note/send";
	}

	// 다중체크박스 ajax로 처리
	@ResponseBody
	@PostMapping("/checkMsgNo")
	public int checkMsgNo(@RequestBody NoteVO noteVO) {
//	public int checkMsgNo(@RequestBody String msgNoString) {
//		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		UserDetails userDetails = (UserDetails)principal;
//		String username = userDetails.getUsername();
//
		log.info("noteVO : " + noteVO);

		// MSG0005,MSG0002
		String msgNo = noteVO.getMsgNoString();
		log.info("msgNo : " + msgNo);

		int result = this.noteService.changeStatus(msgNo);

		return result;
	}

	//다중삭제
	@ResponseBody
	@PostMapping("/deletePost")
	public int deletePost(@RequestBody NoteVO noteVO) {
		log.info("noteVO : " + noteVO);

		int result = noteService.deletePost(noteVO);

		log.info("result : " + result);

		return result;
	}
	
	//받은쪽지함 상세보기에서 삭제
	@ResponseBody
	@PostMapping("/detailDelete")
	public int detailDelete(@RequestBody NoteVO noteVO) {
		log.info("delete noteVO : " + noteVO);
		
		int result = noteService.detailDelete(noteVO);
		
		log.info("result : " + result);
		
		return result;
	}

	//보낸쪽지함 다중 삭제
	@ResponseBody
	@PostMapping("/sendDeletePost")
	public int sendDeletePost(@RequestBody NoteVO noteVO) {
		log.info("noteVO : " + noteVO);

		//MSGRCVR0007	MSG0007인것 삭제하고 싶은데   MSG0007인것 2개 삭제됨 
		//MSGRCVR안받아옴..  
		
		int result = noteService.deletePost(noteVO);

		log.info("result : " + result);

		return result;
	}

	//보관함 다중삭제
	@ResponseBody
	@PostMapping("/keepDeletePost")
	public int keepDeletePost(@RequestBody NoteVO noteVO) {
		log.info("noteVO : " + noteVO);

		int result = noteService.deletePost(noteVO);

		log.info("result : " + result);

		return result;
	}

	//답장
	@GetMapping("/reply")
	public String reply(@ModelAttribute NoteVO noteVO) {
		log.info("noteVO reply : " + noteVO);
//		noteVO.setEmpNoRcvr(noteVO.getEmpNoSndpty());
//		
//		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		UserDetails userDetails = (UserDetails) principal;
//		String username = userDetails.getUsername();
//
//		noteVO.setEmpNoSndpty(username);
//		
//		log.info("noteVO 바바 : " + noteVO);
//		
//		if (noteVO.getMsgCateTag() == null || noteVO.getMsgCateTag().equals("")) {
//			noteVO.setMsgCateTag("일반");
//		} else {
//			noteVO.setMsgCateTag("긴급");
//		}
//		
//		noteVO.setRcvr(noteVO.getSender());
//				
//		log.info("noteVO 바바2 : " + noteVO);
		
//		int result = noteService.reply(noteVO);
//
//		log.info("result : " + result);

		return "note/reply";

	}

	//받은메일함 상세보기의 답장
	@PostMapping("/replyPost")
	public String replyPost(@ModelAttribute NoteVO noteVO) {
		log.info("><noteVO : " + noteVO);
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		String username = userDetails.getUsername();

		noteVO.setEmpNoSndpty(username);
	//	noteVO.setEmpNoRcvr(noteVO.getEmpNoSndpty());
		
		log.info("수신자번호 바꾼 noteVO : " + noteVO);

		if (noteVO.getMsgCateTag() == null || noteVO.getMsgCateTag().equals("")) {
			noteVO.setMsgCateTag("일반");
		} else {
			noteVO.setMsgCateTag("긴급");
		}

		log.info("><><noteVO : " + noteVO);

		int result = noteService.reply(noteVO);

		log.info("result : " + result);

		return "redirect:/note/send";
	}

	
	@ResponseBody
	@PostMapping("/deliver")
	public NoteVO deliver(Model model, @RequestBody NoteVO noteVO) {
		log.info("deliver noteVO : " + noteVO);
					
		model.addAttribute("data",noteVO);
		
		
		return noteVO;
	}
	
	//쪽지 기본키를 가지고 내용 조회
	@GetMapping("/deliverNo")
	public String deliverNo(Model model, @ModelAttribute NoteVO noteVO) {
		model.addAttribute("pageMain", "My Page");
		model.addAttribute("pageDetail", "note");
		model.addAttribute("pageName", "쪽지전달");
		
		log.info("deliver noteVO getMapping : " + noteVO);
		
		noteVO = noteService.deliver(noteVO);
		log.info("deliver noteVO getMapping after : " + noteVO);
		
		model.addAttribute("noteVO",noteVO);		
		
		return "note/deliver";
	}
	
	
	



}






package kr.or.ddit.controller;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.AddressService;
import kr.or.ddit.service.EmpService;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.MailService;
import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.MailVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/mail")
@Controller
public class MailController {

	@Autowired
	MailService mailService;
	@Autowired
	AddressService addressService;
	@Autowired
	FileService fileService;
	@Autowired
	EmpService empService;

	//받은메일 목록 조회
	@GetMapping("/recieveList")
	public String list(Model model, @ModelAttribute MailVO mailVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		mailVO.setEmpNo(username);
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","receiveList");
		model.addAttribute("pageName","받은메일함");


		List<MailVO> recieveEMLList = mailService.recieveEMLList(mailVO);

		model.addAttribute("data", recieveEMLList);

		return "mail/recieveList";
	}

	//전체메일 건수 가져오는 함수
	@ResponseBody
	@GetMapping("/totalCnt")
	public int totalCnt(String username) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		username = userDetails.getUsername();

		int totalMailCnt = mailService.totalMailCnt(username);

		return totalMailCnt;
	}

	//안읽은 메일 건수 가져오는 함수
	@ResponseBody
	@GetMapping("/unReadCnt")
	public int unReadCnt(String username) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		username = userDetails.getUsername();

		int unReadMailCnt = mailService.unReadMailCnt(username);
		log.info("unReadMailCnt : " + unReadMailCnt);

		return unReadMailCnt;
	}

	//상세보기
	@GetMapping("/detail")
	public String detail(@ModelAttribute MailVO mailVO, Model model) {
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","detail");
		model.addAttribute("pageName","메일 상세");

		log.info("mailVO:"+ mailVO);

		MailVO mailDetail = mailService.detail(mailVO);
		log.info("mailDetail:"+ mailDetail);

		if(mailDetail.getFileGroupNo() != null) {
			// 첨부파일 정보 불러오기 (그룹번호에 들어있는 파일 목록 가져오기)
			List<FilesVO> fileVOList = this.fileService.getFilesList(mailDetail.getFileGroupNo());
			model.addAttribute("fileVOList",fileVOList);
		}

		model.addAttribute("data", mailDetail);

		return "mail/detail";
	}

	@GetMapping("/write")
	public String write(Model model, @ModelAttribute AddrVO addrVO,
			@RequestParam(value="searchType", required = false) String searchType,
			@RequestParam(value="keyword", required = false) String keyword) {
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","write");
		model.addAttribute("pageName","메일 작성");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		addrVO.setEmpNo(username);

		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
	    map.put("searchType", searchType);
	    map.put("keyword", keyword);

	    List<AddrVO> addrList = addressService.addrList(map);
	    log.info("addrList 그만 : " + addrList);

	    model.addAttribute("addrVO", addrVO);
	    model.addAttribute("data", addrList);
		model.addAttribute("searchType", searchType);

		return "mail/write";
	}

//	메일쓰기의 주소록 ajax로 불러오기 위한 메소드
	@ResponseBody
	@GetMapping("/addrAjax")
	public List<AddrVO> addrAjax(
			@RequestParam(value="searchType", required = false) String searchType,
			@RequestParam(value="keyword", required = false) String keyword){
		log.info("searchType : " + searchType);
		log.info("keyword : " + keyword);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

//		addrVO.setEmpNo(username);

		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
	    map.put("searchType", searchType);
	    map.put("keyword", keyword);

	    log.info("map : " + map);
	    List<AddrVO> addrList = addressService.addrList(map);
	    log.info("addrList : " + addrList);

		return addrList;
	}

	//메일쓰기의 주소록 체크된 값들 ajax로 비동처러리하는 메소드
	@ResponseBody
	@PostMapping("/checkAddr")
	public List<String> checkAddr(@RequestBody AddrVO addrVO) {
		log.info("1 addrVO : " + addrVO);

		for(int addrNoArr : addrVO.getAddrNoArray()) {
			addrVO.setAddrNo(addrNoArr);
		}
		log.info("2 addrVO : " + addrVO);

		List<AddrVO> checkAddrList = addressService.checkAddr(addrVO);
		log.info("checkAddrList : " + checkAddrList);

		List<String> emlAddrList = new ArrayList<String>();

		for(AddrVO addrList : checkAddrList) {
			log.info("addrList : " + addrList);

			String emlAddr =addrList.getEmlAddr();

			log.info("emlAddr : " + emlAddr);

			emlAddrList.add(emlAddr);
		}
		log.info("emlAddrList :" + emlAddrList);

		return emlAddrList;
	}

	//내메일주소 받아오기(메일쓰기에서 사용)
	@ResponseBody
//	produces : text로 ajax의 text로 맞춘거
	@RequestMapping(value="/myEmail", produces = "text/plain; charset=utf-8")
	public ResponseEntity<String> myEmail() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		AddrVO addrVO = new AddrVO();
		log.info("username" + username);

		addrVO.setEmpNo(username);

		log.info("addrVO 1 :" + addrVO);

		String getMyEmail = addressService.getMyEmail(addrVO);

		log.info("addrVO 2 :" + addrVO);
		log.info("getMyEmail : " + getMyEmail);

		//String으로 getMyEmail을 리턴해도됨. 그땐 메소드 타입도 String으로 맞춰줘야함.
		ResponseEntity<String> entity = new ResponseEntity<String>(getMyEmail, HttpStatus.OK);
		return entity;
	}


	//메일쓰기
	//요청파라미터 : emlSndrNo=,
	@PostMapping("/writePost")
	public String writePost(@ModelAttribute MailVO mailVO, String code, RedirectAttributes ra, Model model) {
		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		mailVO.setEmpNo(empVO.getEmpNo());

		log.info("mailVO 됐? : " + mailVO);
		log.info("wholBVO.getUploadFile()  : " + mailVO.getUploadFile());

		int result = this.mailService.writePost(mailVO);
		log.info("mailVO 222222 : " + mailVO);

		int filesRes = 0;
		if(mailVO.getUploadFile() != null) {
			log.info("----------------------------2");
			filesRes = this.fileService.MailFileCreate(mailVO);
			log.info("fileRes : " + filesRes);
			if(filesRes>0) {
				// 메일 그룹번호 수정
				MailVO mailVO2 = new MailVO();
				mailVO2.setEmlNo(mailVO.getEmlNo());
				mailVO2.setFileGroupNo(mailVO.getFileGroupNo());
				this.mailService.mailModify(mailVO2);
			}
		}

		if(code != null && !code.equals("") && code.equals("close")) {
			ra.addFlashAttribute("close", code);
		}


		log.info("result 됐니? : " + result);

		model.addAttribute("data", mailVO);
		return "redirect:/mail/mailSend";

	}

	//연/월/일 폴더 생성
	public static String getFolder() {
		//2023-01-27형식(format) 지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");

		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2023-01-27 =>2023File.separator01File.separator27
		String str = sdf.format(date);
		//단순 날짜 문자를 File객체의 폴더 타입으로 바꾸기
		//\\2023\\01\\27
		//File.separator은 "-"를 찾아서 폴더로 만드는역할(\\ : 폴더나타내는 표시)
		return str.replace("-", File.separator);
	}

	//썸네일 처리
	//용량이 큰 파일을 썸네일 처리를 하지 않으면
	//모바일과 같은 환경에서 많은 데이터를 소비해야 하므로
	//이미지의 경우 특별한 경우가 아니면 썸네일을 제작해야 함
	//썸네일은 이미지만 가능함
	public static boolean checkImageType(File file) {
		/*
		.jpeg / .jpg(JPEG 이미지)의 MIME 타입 : image/jpeg
		*/
		//MIME 타입을 통한 이미지 여부 확인
		try {
			//file.toPath() : 파일 객체를 path객체로 변환
			String contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//MIME 타입정보가 image로 시작하는지 여부를 return
			return contentType.startsWith("image");
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}

	//보낸메일 목록 조회
	@GetMapping("/send")
	public String send(Model model, @ModelAttribute MailVO mailVO) {
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","send");
		model.addAttribute("pageName","보낸 메일함");

		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();
		log.info("empVO 다다? : " + empVO);


		mailVO.setEmpNo(empVO.getEmpNo());

		List<MailVO> sendList = mailService.send(mailVO);
		log.info("sendList : " + sendList);

		model.addAttribute("data", sendList);

		return "mail/send";
	}

	//수신확인 목록 조회
	@GetMapping("/check")
	public String check(Model model, @ModelAttribute MailVO mailVO) {
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","check");
		model.addAttribute("pageName","메일 수신확인");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		mailVO.setEmpNo(username);

		List<MailVO> checkMailList = mailService.checkMail(mailVO);
		log.info("checkMailList : " + checkMailList);

		model.addAttribute("data",checkMailList);

		return "mail/check";
	}
	
	//휴지통 목록 조회
	@GetMapping("/trash")
	public String trash(Model model, @ModelAttribute MailVO mailVO) {
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","trash");
		model.addAttribute("pageName","휴지통");

		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		mailVO.setEmpNo(empVO.getEmpNo());

		List<MailVO> selectTrash = mailService.selectTrash(mailVO);

		log.info("selectTrash : " + selectTrash);
		model.addAttribute("data",selectTrash);

		return "mail/trash";
	}

	//삭제누르면 휴지통으로 보내짐.
	@ResponseBody
	@PostMapping("delEml")
	public int delEml(@RequestBody MailVO mailVO) {
		log.info("mailVO@@ : " + mailVO);
		
		int result = mailService.delEml(mailVO);

		log.info("result@@ : " + result);

		return result;
	}

	//중요메일함
	@GetMapping("/importantEml")
	public String importantEml(Model model) {
		List<MailVO> impEmlList = mailService.impEmlList();

		log.info("impEmlList : " + impEmlList);
		
		model.addAttribute("impEmlList", impEmlList);

		return "mail/importantEml";
	}
	
//	중요메일함으로 이동
	@GetMapping("/sendImp")
	public String sendImp(@RequestParam String emlNo, Model model) {
		log.info("emlNo와쓰? : " + emlNo);

		int result = mailService.sendImp(emlNo);
		log.info("result와쓰? : " + result);

		model.addAttribute("emlNo", emlNo);

		return "redirect:/mail/importantEml";
	}

	//받은메일함에서 삭제(휴지통으로 이동됨)
	@ResponseBody
	@PostMapping("/delTrashPost")
	public int delTrashPost(@RequestBody MailVO mailVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		mailVO.setEmpNo(username);
		log.info("mailVO : " + mailVO);

		int delTrashPost = mailService.delTrashPost(mailVO);
		log.info("delTrashPost : " + delTrashPost);

		return delTrashPost;
	}

	//휴지통에서 삭제
	@ResponseBody
	@PostMapping("/delPost")
	public int delPost(@RequestBody MailVO mailVO) {
		log.info("mailVO 오나요: " + mailVO);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		mailVO.setEmpNo(username);
		log.info("mailVO !: " + mailVO);

		int delPost = mailService.delPost(mailVO);
		log.info("delPost : " + delPost);

		return delPost;
	}

	//휴지통에서 복원
	@ResponseBody
	@PostMapping("/resetPost")
	public int resetPost(@RequestBody MailVO mailVO) {
	log.info("mailVO 오나요: " + mailVO);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		mailVO.setEmpNo(username);
		log.info("mailVO !: " + mailVO);

		int result = mailService.resetPost(mailVO);

		return result;
	}

	//MailVO(emlNo=null, empNo=null, emlTagNo=EML_TAG01, emlTagcol=null, rcvrYn=null
	//, empNm=null, emlClsfNo=null, emlTtl=null, emlCn=null, fileGroupNo=null
	//, emlTrsmDt=null, emlImporYn=null, emlSndrNo=null
	//, emlNoArray=[EML0435, EML0430], prev=null, rslt=0, emailRcvrVOList=null)
	@ResponseBody
	@PostMapping("/insertTag")
	public String insertTag(@RequestBody MailVO mailVO) {
		log.info("mailVO : " + mailVO);

		int result = this.mailService.insertTag(mailVO);
		log.info("result : " + result);

		return "1";
	}

//	@GetMapping("/tagList")
//	public String tagList(@ModelAttribute MailVO mailVO, Model model) {
//		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		UserDetails userDetails = (UserDetails)principal;
//		String username = userDetails.getUsername();
//
//		mailVO.setEmpNo(username);
//
//		log.info("mailVO #: " + mailVO);
//
//		List<MailVO> tagList = mailService.tagList(mailVO);
//
//		log.info("tagList #: " + tagList);
//
//		//태그별로 MailVO리스트 생성
//		List<MailVO> managementList = new ArrayList<MailVO>();
//		List<MailVO> referenceList = new ArrayList<MailVO>();
//		List<MailVO> accontingList = new ArrayList<MailVO>();
//		//반복문으로 tagList에 있는 메일 목록을 태그별로 분류해서 각각의 리스트에 넣어주기
//		for(int i=0; i<tagList.size(); i++) {
//			if(tagList.get(i).getEmlTagNo().equals("EML_TAG01")) {
//				managementList.add(tagList.get(i));
//			}
//			if(tagList.get(i).getEmlTagNo().equals("EML_TAG02")) {
//				referenceList.add(tagList.get(i));
//			}
//			if(tagList.get(i).getEmlTagNo().equals("EML_TAG03")) {
//				accontingList.add(tagList.get(i));
//			}
//		}
//		model.addAttribute("managementList", managementList);
//		model.addAttribute("referenceList", referenceList);
//		model.addAttribute("accontingList", accontingList);
//
//
//		return "mail/managementTag";
//	}

	//경영태그
	@GetMapping("/managementTag")
	public String managementTag(@ModelAttribute MailVO mailVO, Model model) {
		
		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();
		
		mailVO.setEmlRcvrAddr(empVO.getEmpEmlAddr()); 
		

		List<MailVO> managementTag = mailService.managementTag(mailVO);
		log.info("managementTag #: " + managementTag);

		model.addAttribute("data",managementTag);

		return "mail/managementTag";

	}

	//참고자료
	@GetMapping("/referenceTag")
	public String referenceTag(@ModelAttribute MailVO mailVO, Model model) {
		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();
		
		mailVO.setEmlRcvrAddr(empVO.getEmpEmlAddr()); 

		List<MailVO> referenceTag = mailService.referenceTag(mailVO);
		log.info("referenceTag #: " + referenceTag);

		model.addAttribute("data",referenceTag);

		return "mail/referenceTag";

	}

	//회계자료
	@GetMapping("/accontingTag")
	public String accontingTag(@ModelAttribute MailVO mailVO, Model model) {
		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();
		
		mailVO.setEmlRcvrAddr(empVO.getEmpEmlAddr()); 

		List<MailVO> accontingTag = mailService.accontingTag(mailVO);
		log.info("accontingTag #: " + accontingTag);

		model.addAttribute("data",accontingTag);

		return "mail/accontingTag";

	}
	
	//메일 전송 후 
	@GetMapping("/mailSend")
	public String mailSend(Model model) {
		model.addAttribute("pageMain","Mail");
		model.addAttribute("pageDetail","mailSend");
		model.addAttribute("pageName","메일 전송확인");

		return "mail/mailSend";
	}
	
	//사원정보 이메일 클릭시 메일쓰기
	@GetMapping("/clickWrite")
	public String clickWrite(@RequestParam(value = "empNo", required = false) String empNo
			,Model model) {
		
		String emlAddr = empService.findEmlAddr(empNo);
		
		log.info("emlAddr : " + emlAddr);
		
		model.addAttribute("emlAddr",emlAddr);
		
		return "mail/write";
		
	}
}





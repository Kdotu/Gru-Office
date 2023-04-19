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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.WholBService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.WholBVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminBoardController {
	@Autowired
	WholBService wholBService;
	@Autowired
	FileService fileService;

	//공지게시글 등록(관리자)
	@PostMapping("/noticeBWritePost")
	public String noticeBWritePost(@ModelAttribute WholBVO wholBVO, Model model) {
		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		wholBVO.setEmpNo(empVO.getEmpNo());
		log.info("wholBVO 다왔? : " + wholBVO);
		log.info("wholBVO.getUploadFile()  : " + wholBVO.getUploadFile() );

		WholBVO boardVO = new WholBVO();
		boardVO.setWholBbsNo(wholBVO.getWholBbsNo());
		boardVO.setUploadFile(wholBVO.getUploadFile());
		log.info("----------------------------1");
		log.info("boardVO : " + boardVO);

		int result = wholBService.noticeBWritePost(wholBVO);
		int filesRes = 0;
		if(wholBVO.getUploadFile() != null) {
			log.info("----------------------------2");
			filesRes = this.fileService.BoardFileCreate(wholBVO);
			log.info("fileRes : " + filesRes);
		}

		log.info("result ㅋ: " + result);

		model.addAttribute("authority","admin");
		return "redirect:/admin/admNoticeList.admin";
	}

	//공지게시글 목록조회(관리자)
	@GetMapping("/admNoticeList")
	public String admNoticeList(Model model) {
		model.addAttribute("pageMain","AdminBoard");
		model.addAttribute("pageDetail","admNoticeList");
		model.addAttribute("pageName","공지게시판");

		List<WholBVO> noticeBList = wholBService.noticeBList();
//		log.info("관리자공지게시판 : " + noticeBList);

		model.addAttribute("data",noticeBList);
		model.addAttribute("authority","admin");
		return "admin/admNoticeList.admin";
	}

	//전사게시글 목록 조회
	@GetMapping("/wholBList")
	public String wholBList(Model model,WholBVO wholBVO) {
		model.addAttribute("pageMain","AdminBoard");
		model.addAttribute("pageDetail","wholBList");
		model.addAttribute("pageName","전사게시판");

		model.addAttribute("authority","admin");
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		wholBVO.setEmpNo(username);

		List<WholBVO> wholBList = wholBService.wholBList(wholBVO);
		log.info("wholBList : " + wholBList);
		
		model.addAttribute("data", wholBList);

		return "admin/wholBList.admin";
	}

	
	@GetMapping("/noticeBWrite")
	public String noticeBWrite(Model model) {
		model.addAttribute("pageMain","AdminBoard");
		model.addAttribute("pageDetail","noticeBWrite");
		model.addAttribute("pageName","공지게시글 작성");

		model.addAttribute("authority","admin");


		return "admin/noticeBWrite.admin";
	}

	//전사게시글 상세보기
	@GetMapping("/admNoticeDtl")
	public String admNoticeDtl(@RequestParam String wholBbsNo, Model model) {
		WholBVO noticeBDetail = wholBService.noticeBDetail(wholBbsNo);
		model.addAttribute("pageMain","AdminBoard");
		model.addAttribute("pageDetail","admNoticeDtl");
		model.addAttribute("pageName","공지게시판 상세");


		log.info("noticeBDetail : " + noticeBDetail);


		if(noticeBDetail.getFileGroupNo() != null) {
			// 첨부파일 정보 불러오기 (그룹번호에 들어있는 파일 목록 가져오기)
			List<FilesVO> fileVOList = this.fileService.getFilesList(noticeBDetail.getFileGroupNo());
			model.addAttribute("fileVOList",fileVOList);
		}


		model.addAttribute("data",noticeBDetail);
		model.addAttribute("authority","admin");
		return "admin/admNoticeDtl.admin";
	}

}

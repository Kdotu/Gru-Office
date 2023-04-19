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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.WholBService;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.GoodVO;
import kr.or.ddit.vo.WholBVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	WholBService wholBService;
	@Autowired
	FileService fileService;

	//전사게시글 목록 조회
	@GetMapping("/wholBList")
	public String wholBList(@ModelAttribute WholBVO wholBVO, Model model) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","WholdBoard");
		model.addAttribute("pageName","전사게시판");
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		wholBVO.setEmpNo(username);

		List<WholBVO> wholBList = wholBService.wholBList(wholBVO);
		log.info("wholBList : " + wholBList);

		model.addAttribute("data", wholBList);

		return "board/wholBList";
	}



//	@GetMapping("/noticeBList")
//	public String noticeBList(Model model) {
//		model.addAttribute("pageMain","Board");
//		model.addAttribute("pageDetail","notice");
//		model.addAttribute("pageName","공지게시판");
//
//		return "board/noticeBList";
//	}

//	@GetMapping("/depBList")
//	public String depBList(Model model) {
//		model.addAttribute("pageMain","Board");
//		model.addAttribute("pageDetail","dept board");
//		model.addAttribute("pageName","부서게시판");
//
//		return "board/depBList";
//	}

	//내가쓴글 조회하기
	@GetMapping("/myList")
	public String myList(Model model, @ModelAttribute WholBVO wholBVO) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","myList");
		model.addAttribute("pageName","내가 쓴 글");


		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		wholBVO.setEmpNo(empVO.getEmpNo());
		wholBVO.setEmpNm(empVO.getEmpNm());

		log.info("wholBVO 내글 : " + wholBVO);

		List<WholBVO> wholBVOList = wholBService.selMyBList(wholBVO);

		log.info("wholBVOList : " + wholBVOList);

		model.addAttribute("data", wholBVOList);

		return "board/myList";
	}


	@GetMapping("/wholBWrite")
	public String wholBWrite() {
		log.info("게시판 들어옴?");

		return "board/wholBWrite";
	}

	//전사게시글 등록
	@PostMapping("/wholBWritePost")
	public String wholBWritePost(@ModelAttribute WholBVO wholBVO) {
		//WholBVO(wholBbsNo=null, empNo=null, rnum=0, empNm=null, bbsClsfNo=null, popupYn=null, fileGroupNo=null, wholBbsTtl=지워져랏11, wholBbsCn=<ol>
		//, wholBbsRegYmd=null, wholBbsInqCnt=0, cntGood=0, deptNo=null, boardCmntList=null,
		//uploadFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@1540bd07]
		//, fileGrVO=null, filesVOList=null)
		log.info("wholBVO : " + wholBVO);

		//로그인 사용자 아이디
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		wholBVO.setEmpNo(username);

		log.info("wholBVO %: " + wholBVO);
		//WHOL_BBS 테이블의 FILE_GROUP_NO 컬럼에는 null임
		//연월일 폴더에 업로드외면서
		//FILES테이블에 insert -> WHOL_BBS 테이블에 insert
		int result = wholBService.wholBWritePost(wholBVO);
		log.info("result : " + result);

		int filesRes = 0;
		//업로드할 파일이 있다면..
		if(wholBVO.getUploadFile() != null) {
			filesRes = this.fileService.BoardFileCreate(wholBVO);
		}
		// 게시판 그룹번호 수정
		WholBVO boardVO = new WholBVO();
		boardVO.setWholBbsNo(wholBVO.getWholBbsNo());
		boardVO.setFileGroupNo(wholBVO.getFileGroupNo());
		this.wholBService.wholBModify(boardVO);


		return "redirect:/board/wholBList";
	}

	@GetMapping("/depBWrite")
	public String depBWrite() {
		return "board/depBWrite";
	}

	//부서게시글 등록
	@PostMapping("depBWritePost")
	public String depBWritePostPost(@ModelAttribute WholBVO wholBVO) {
		log.info("wholBVO : " + wholBVO);

		int result = wholBService.depBWritePost(wholBVO);

		// 파일 업로드
		int filesRes = 0;
		if(wholBVO.getUploadFile() != null) {
			filesRes = this.fileService.BoardFileCreate(wholBVO);
		}
		// 게시판 그룹번호 수정
		WholBVO boardVO = new WholBVO();
		boardVO.setWholBbsNo(wholBVO.getWholBbsNo());
		boardVO.setFileGroupNo(wholBVO.getFileGroupNo());
		this.wholBService.wholBModify(boardVO);

		return "redirect:/board/depBList";
	  }

	//전사게시글 수정
	@ResponseBody
	@PostMapping("wholBModi")
	public String wholBModi(@RequestBody WholBVO wholBVO) {
		log.info("wholBVO 1: " + wholBVO);

		wholBVO = wholBService.selectLow(wholBVO);
		log.info("wholBVO 2: " + wholBVO);

		int wholBModi = wholBService.wholBModi(wholBVO);
		log.info("wholBVO 3(): " + wholBVO);

//		return "board/wholBModi";
		return "board/wholBDetail";
	}



//	@PostMapping("/writePost")
//	public String writePost(@ModelAttribute WholBVO wholBVO, Model model) {
//		log.info("wholBVO : " + wholBVO);
//		int result =  wholBService.writePost(wholBVO);
//
////		리턴 조건문 줘서 다르게 가도록!!
//		if(result >=1 && wholBVO.getBbsClsfNo().equals("BBS_CLSF02")) {
//			return "board/wholBList";
//		}
//		else if(result >=1 && wholBVO.getBbsClsfNo().equals("BBS_CLSF03")) {
//			return "board/depBList";
//		}
//		else {
//			return "board/write";
//		}
//	}

	//게시판 메인
	@GetMapping("/totalList")
	public String totalList(Model model) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","게시판 메인");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		List<WholBVO> mainNotice = wholBService.mainNotice();
		List<WholBVO> mainWhole = wholBService.mainWhole();
		List<WholBVO> mainDept = wholBService.mainDept(username);
		String deptNm = wholBService.getDeptNm(username);

		model.addAttribute("mainNotice", mainNotice);
		model.addAttribute("mainWhole", mainWhole);
		model.addAttribute("mainDept", mainDept);
		model.addAttribute("deptNm", deptNm);

		return "board/totalList";
	}

	//전사게시글 상세보기
	@GetMapping("/wholBDetail")
	public String whoBDetail(@ModelAttribute WholBVO wholBVO,@ModelAttribute GoodVO goodVO, Model model) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","WholdBDetail");
		model.addAttribute("pageName","전사게시글 상세보기");

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();
		log.info("username : " + username);
		wholBVO.setEmpNo(username);
		goodVO.setEmpNo(username);

		log.info("wholBVO 바보 : " + wholBVO);

		WholBVO wholBDetail = wholBService.wholBDetail(wholBVO.getWholBbsNo());
		log.info("wholBDetail 바보 : " + wholBDetail);

		log.info("goodVO : " + goodVO);

		//좋아요 클릭 수 조회
		int goodCnt = wholBService.selectCnt(goodVO);
		log.info("goodCnt : " + goodCnt);

		//댓글 수 조회
		int cmntCnt = wholBService.cmntCnt(wholBVO);

		if(wholBDetail.getFileGroupNo() != null) {
			// 첨부파일 정보 불러오기 (그룹번호에 들어있는 파일 목록 가져오기)
			List<FilesVO> fileVOList = this.fileService.getFilesList(wholBDetail.getFileGroupNo());
			log.info("fileVOList : " + fileVOList);
			model.addAttribute("fileVOList",fileVOList);
		}

		model.addAttribute("data", wholBDetail);
		model.addAttribute("cmntCnt", cmntCnt);
		model.addAttribute("goodCnt", goodCnt);


		return "board/wholBDetail";
	}

	//전사게시글 좋아요
	@ResponseBody
	@PostMapping("/wholBLikeUp")
	public int wholBLikeUp(@RequestBody GoodVO goodVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();
		log.info("username1 : " + username);

		goodVO.setEmpNo(username);

		log.info("goodVO : " + goodVO);

		int result = wholBService.wholBLikeUp(goodVO);

		log.info("result 컨트 : " + result);

		return result;
	}

	//전사게시글 삭제
	@ResponseBody
	@PostMapping("/delWholB")
	public int delWholB(@RequestBody WholBVO wholBVO) {
		log.info("전사삭제 wholBVO : " + wholBVO);

		int result = wholBService.delWholB(wholBVO);
		log.info("전사삭제 result : " + result);

		return result;
	}

	//댓글등록
	@ResponseBody
	@PostMapping("/createCmnt")
	public int createCmnt(@RequestBody CmntVO CmntVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		CmntVO.setEmpNo(username);

		log.info("CmntVO 요기요 : " + CmntVO);

		int result = wholBService.createCmnt(CmntVO);

		log.info("result댓글 : " + result);

		return result;
	}

	//댓글 수정
	@ResponseBody
	@PostMapping("/updateCmnt")
	public int updateCmnt(@RequestBody CmntVO cmntVO) {
		log.info("cmntVO 드루와 : " + cmntVO);

		int result = wholBService.updateCmnt(cmntVO);
		return result;
	}

	//댓글 삭제
	@ResponseBody
	@PostMapping("/deleteCmnt")
	public int deleteCmnt(@RequestBody CmntVO cmntVO) {
		log.info("여기오니?");
		log.info("cmntNo@@ : " + cmntVO );

		int result = wholBService.deleteCmnt(cmntVO);

		log.info("result@@ : " + result);

		return result;
	}

	//부서게시글 목록 조회
	@GetMapping("/depBList")
	public String depBList(@ModelAttribute WholBVO wholBVO, Model model) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","dept board");
		model.addAttribute("pageName","부서게시판");

		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();
		log.info("empVO 다다? : " + empVO);

		wholBVO.setDeptNo(empVO.getDeptNo());
		wholBVO.setEmpNo(empVO.getEmpNo());
		wholBVO.setEmpNm(empVO.getEmpNm());

		log.info("wholBVO 다다? : " + wholBVO);

//		// 서비스쪽으로 userName(id)에 해당하는 부서 번호를 가져와야함(2개 쿼리 있어야함)
//		String deptNo = wholBService.selDepNo(wholBVO);
//		wholBVO.setDeptNo(deptNo);
//		log.info("wholBVO 부서왔어? : " + wholBVO);


		List<WholBVO> depBList = wholBService.depBList(wholBVO);
		log.info("depBList : " + depBList);

		model.addAttribute("data", depBList);

		return "board/depBList";
	}

	//공지게시글 목록 조회
	@GetMapping("/noticeBList")
	public String noticeBList(@ModelAttribute WholBVO wholBVO, Model model) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","notice");
		model.addAttribute("pageName","공지게시판");

		log.info("wholBVO머가? : " + wholBVO);

		List<WholBVO> noticeBList = wholBService.noticeBList();
		log.info("noticeBList : " + noticeBList);

		model.addAttribute("data",noticeBList);

		return "board/noticeBList";
	}

//	@GetMapping("/wholBDetail")
//	public String whoBDetail(@ModelAttribute WholBVO wholBVO, Model model) {
//		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		UserDetails userDetails = (UserDetails)principal;
//		String username = userDetails.getUsername();
//		log.info("username : " + username);
//		wholBVO.setEmpNo(username);
//
//		WholBVO wholBDetail = wholBService.wholBDetail(wholBVO);
//		log.info("wholBDetail : " + wholBDetail);
//
//		//댓글 수 조회
//		int cmntCnt = wholBService.cmntCnt(wholBVO);
//
//		if(wholBVO.getFileGroupNo() != null) {
//			// 첨부파일 정보 불러오기 (그룹번호에 들어있는 파일 목록 가져오기)
//			List<FilesVO> fileVOList = this.fileService.getFilesList(wholBVO.getFileGroupNo());
//			model.addAttribute("fileVOList",fileVOList);
//		}
//
//		model.addAttribute("data", wholBDetail);
//		model.addAttribute("cmntCnt", cmntCnt);
//
//
//		return "board/wholBDetail";
//	}

	//공지게시글 상세보기
	@GetMapping("/noticeBDetail")
	public String noticeBDetail(@RequestParam String wholBbsNo, @ModelAttribute WholBVO wholBVO, Model model) {
		model.addAttribute("pageMain","Board");
		model.addAttribute("pageDetail","noticeDetail");
		model.addAttribute("pageName","공지게시판 상세");


		log.info("wholBbsNo 됐누" + wholBbsNo);
		log.info("WholBVO 됐누" + wholBVO);


		WholBVO noticeBDetail = wholBService.noticeBDetail(wholBbsNo);

		log.info("noticeBDetail : " + noticeBDetail);

		model.addAttribute("data",noticeBDetail);

		return "board/noticeBDetail";
	}

	@GetMapping("noticeBWrite")
	public String noticeBWrite() {

		return "admin/noticeBWrite";
	}

	//공지게시글 등록
	@PostMapping("/noticeBWritePost")
	public String noticeBWritePost(@ModelAttribute WholBVO wholBVO) {
		//empVO에 로그인한 사원정보 다 있음.
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		CustomUser principal = (CustomUser)auth.getPrincipal();
		EmpVO empVO = principal.getEmpVO();

		wholBVO.setEmpNo(empVO.getEmpNo());
		log.info("wholBVO 다왔? : " + wholBVO);
		int result = wholBService.noticeBWritePost(wholBVO);


		// 파일 업로드
		int filesRes = 0;
		if(wholBVO.getUploadFile() != null) {
			filesRes = this.fileService.BoardFileCreate(wholBVO);
		}
		// 게시판 그룹번호 수정
		WholBVO boardVO = new WholBVO();
		boardVO.setWholBbsNo(wholBVO.getWholBbsNo());
		boardVO.setFileGroupNo(wholBVO.getFileGroupNo());
		this.wholBService.wholBModify(boardVO);


		log.info("result ㅋ: " + result);
		return "redirect:/admin/admNoticeList";
	}

	//공지게시글 목록 조회(관리자)
	@GetMapping("/admNoticeList")
	public String admNoticeList() {

		return "admin/admNoticeList";
	}

	////공지게시글 등록(관리자)
	@GetMapping("/admNoticeWrite")
	public String admNoticeWrite() {

		return "admin/admNoticeWrite";
	}

//	@ResponseBody
//	@PostMapping("admWritePost")
//	public String admWritePost(@RequestBody WholBVO wholBVO) {
//		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		CustomUser principal = (CustomUser)auth.getPrincipal();
//		EmpVO empVO = principal.getEmpVO();
//
//		wholBVO.setEmpNo(empVO.getEmpNo());
//		log.info("wholBVO 다왔? : " + wholBVO);
//		int result = wholBService.noticeBWritePost(wholBVO);
//
//		log.info("result ㅋ: " + result);
//
//		return "redirect:/board/admNoticeList";
//	}


}















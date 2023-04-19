package kr.or.ddit.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.SrvyService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.HashTagListVO;
import kr.or.ddit.vo.HashTagVO;
import kr.or.ddit.vo.SrvyQstnVO;
import kr.or.ddit.vo.SrvyRspnVO;
import kr.or.ddit.vo.SrvyTrprVO;
import kr.or.ddit.vo.SrvyVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-13
 *
 */
/**
 * @author PC-13
 *
 */
@Slf4j
@RequestMapping("/survey")
@Controller
public class SrvyController {

	@Autowired
	SrvyService srvyService;
	@Autowired
	FileService fileService;

	/**
	 * 요청 URI : /localhost/survey/main
	 * 설문조사 메인 페이지
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","설문조사 메인");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

		SrvyVO srvyVO = new SrvyVO();
		srvyVO.setEmpNo(empVO.getEmpNo());

		// 진행/보류/마감/등록한 설문조사의 수
		SrvyVO statusSrvyCnt = this.srvyService.getSrvyCnt(srvyVO);
		log.info("statusSrvyCnt : " + statusSrvyCnt);
		// 대상인 설문조사 목록 가져오기
		List<SrvyVO> SrvyTrprList = this.srvyService.getSrvyTrprList(srvyVO);

		log.info("SrvyTrprList ====>>>: " + SrvyTrprList);

		// 등록한 설문조사 목록 가져오기
		List<SrvyVO> SrvyEnrollList = this.srvyService.getSrvyEnrollList(srvyVO);

		// 등록한 설문조사 중 최신 댓글 가져오기
		List<CmntVO> recentCmntList = this.srvyService.getSrvyRecentComment(srvyVO);

		model.addAttribute("SrvyTrprList",SrvyTrprList);
		model.addAttribute("SrvyEnrollList",SrvyEnrollList);
		model.addAttribute("recentCmntList",recentCmntList);
		model.addAttribute("statusSrvyCnt",statusSrvyCnt);
		return "survey/main";
	}

	/**
	 * 요청 URI : /localhost/survey/list
	 * 상태별로 설문조사 목록을 불러오는 메서드
	 * @param model
	 * @param status (진행중:progress | 마감:end | 등록한설문:enroll)
	 * @return
	 */
	@GetMapping("/list")
	public String list(Model model,String status,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="dateArr1", required = false) String dateArr1,
			@RequestParam(value="dateArr2", required = false) String dateArr2 ) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","list");
		model.addAttribute("pageName","설문조사 목록");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    int size =10;

	    log.info("status : " + status);
		Map<String,Object> srvyMap = new HashMap<String, Object>();
		srvyMap.put("empNo",empVO.getEmpNo());
//		srvyMap.put("authority","emp");
		srvyMap.put("currentPage",currentPage);
		srvyMap.put("size",size);
		srvyMap.put("dateArr1",dateArr1);
		srvyMap.put("dateArr2",dateArr2);

		if(status == null) {
			status = "";
			model.addAttribute("title","전체 설문");
			model.addAttribute("description","전체 설문조사의 목록을 보여줍니다.");
		}else {
			switch (status) {
			case "progress": // 진행중인 설문
				model.addAttribute("title","진행중인 설문");
				model.addAttribute("description","현재 진행중인 설문조사의 목록을 보여줍니다.");
				srvyMap.put("status","progress");
				break;
			case "end": // 마감된 설문
				model.addAttribute("title","마감된 설문");
				model.addAttribute("description","마감된 설문조사의 목록을 보여줍니다.");
				srvyMap.put("status","end");
				break;
			case "hold": // 보류된 설문
				model.addAttribute("title","보류된 설문");
				model.addAttribute("description","등록한 설문조사 중 보류된 목록을 보여줍니다.");
				srvyMap.put("status","hold");
				break;
			case "enroll": // 등록한 설문
				model.addAttribute("title","등록한 설문");
				model.addAttribute("description","등록한 설문조사의 목록을 보여줍니다.");
				srvyMap.put("enroll",empVO.getEmpNo());
				break;

			case "reply": // 답변한 설문
				model.addAttribute("title","답변한 설문");
				model.addAttribute("description","답변한 설문조사의 목록을 보여줍니다.");
				srvyMap.put("reply",empVO.getEmpNo());
				break;
			default:
				break;
			}
		}
		List<SrvyVO> srvyList = this.srvyService.getSrvyList(srvyMap);
		int total = this.srvyService.getSrvyTotal(srvyMap);

		model.addAttribute("status",status);
		model.addAttribute("pNo",currentPage);
		model.addAttribute("loginEmpVO",empVO);
		model.addAttribute("data", new ArticlePage<SrvyVO>(total, currentPage, size, srvyList));
		log.info("srvyList : " + srvyList);

		return "survey/list";
	}
	/**
	 * 요청 URI : /localhost/survey/detail
	 * 설문 상세 및 응답 페이지
	 * @param model
	 * @return
	 */
	@GetMapping("/detail")
	public String detail(
			RedirectAttributes ra, @RequestParam(value="status", required=false) String status,
			Model model,String srvyNo) {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","detail");
		model.addAttribute("pageName","설문조사 상세");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

		// 설문조사 번호로 검색한 설문조사의 상세 정보를 가져옴
		List<SrvyVO> srvyDetailVOList = this.srvyService.getSrvyDetail(srvyNo);
		SrvyVO srvyVO = srvyDetailVOList.get(0);
		SrvyQstnVO srvyQstnVO = srvyVO.getSrvyQstnVOList().get(0);

		Map<String,String> rspnMap = new HashMap<String, String>();
		rspnMap.put("empNo", empVO.getEmpNo());
		rspnMap.put("srvyNo",srvyVO.getSrvyNo());

		// 설문 대상자 정보 불러오기
		List<SrvyTrprVO> trprVOList = this.srvyService.getTrprVOList(srvyVO.getSrvyNo());
		// 해당 회원의 응답 불러오기
		List<SrvyRspnVO> srvyRspnVOList = this.srvyService.getSrvyRspn(rspnMap);
		// 사용한 해시태그 정보 불러오기
		List<HashTagVO> hashTagVOList = this.srvyService.getUsedHashTag(srvyVO);
		// 댓글 정보 불러오기
		List<CmntVO> CmntVOList = this.srvyService.getSrvyComment(srvyVO);
		// 질문에 대한 답변의 수 가져오기 (차트용)
		List<SrvyRspnVO> rspnCntList = this.srvyService.getRspnCntChart(srvyVO);

		if(srvyVO.getFileGroupNo() != null) {
			// 첨부파일 정보 불러오기 (그룹번호에 들어있는 파일 목록 가져오기)
			List<FilesVO> fileVOList = this.fileService.getFilesList(srvyVO.getFileGroupNo());
			model.addAttribute("fileVOList",fileVOList);
		}

		model.addAttribute("trprVOList",trprVOList);
		model.addAttribute("rspnCntList",rspnCntList);
		model.addAttribute("CmntVOList",CmntVOList);
		model.addAttribute("srvyVO",srvyVO);
		model.addAttribute("srvyQstnVO",srvyQstnVO);
		model.addAttribute("srvyRspnVOList",srvyRspnVOList);
		model.addAttribute("hashTagVOList",hashTagVOList);

		if(status != null &&  status.equals("ok")) {
			model.addAttribute("resMsg", "설문 답변등록 완료!");
		}
		return "survey/detail";
	}

	/**
	 * 요청 URI : /localhost/survey/modifySrvy
	 * 설문조사의 내용을 수정하는 메서드
	 * (설문조사 제목, 설문조사 설명, 설문조사 기한 수정 가능)
	 *
	 * @param srvyVO
	 * @return
	 * @throws JsonProcessingException
	 */
	@ResponseBody
	@PostMapping("/modifySrvy")
	public String modifySrvy(@RequestBody SrvyVO srvyVO) throws JsonProcessingException {
		log.info("modifySrvy 1: " + srvyVO);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		List<SrvyVO> srvyDetailVOList = this.srvyService.getSrvyDetail(srvyVO.getSrvyNo());
		srvyVO = srvyDetailVOList.get(0);

		ObjectMapper mapper = new ObjectMapper();
		String srvyDetailVOListStr =  mapper.writeValueAsString(srvyVO);
		return srvyDetailVOListStr;
	}

	/**
	 * 요청 URI : /localhost/survey/create
	 * 설문 등록 페이지
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@GetMapping("/create")
	public String create(Model model) throws JsonProcessingException {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","create");
		model.addAttribute("pageName","설문조사 등록");

		Map<String,String> hashMap = new HashMap<String, String>();
		hashMap.put("useYn","Y");
		List<HashTagListVO> hashTagListVOList = this.srvyService.getHashTagList(hashMap);

		ObjectMapper objMapper = new ObjectMapper();
		String hashTagListVOListStr =objMapper.writeValueAsString(hashTagListVOList);

		log.info("hashTagListVOList : " ,hashTagListVOList);
		log.info("hashTagListVOListStr : " ,hashTagListVOListStr);

		model.addAttribute("hashTagListVOList",hashTagListVOListStr);

		return "survey/create";
	}

	/**
	 * 요청 URI : /localhost/survey/getHashTagList
	 * 해시태그 목록을 불러오는 메서드
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@GetMapping("/getHashTagList")
	@ResponseBody
	public String getHashTagList(Model model) throws JsonProcessingException {
		Map<String,String> hashMap = new HashMap<String, String>();
		hashMap.put("useYn","Y");
		List<HashTagListVO> hashTagListVOList = this.srvyService.getHashTagList(hashMap);

		ObjectMapper objMapper = new ObjectMapper();
		String hashTagListVOListStr =objMapper.writeValueAsString(hashTagListVOList);

		model.addAttribute("hashTagListVOList",hashTagListVOList);
		log.info("hashTagListVOList : ",hashTagListVOList);
		return hashTagListVOListStr;
	}

	/**
	 * 요청 URI : /localhost/survey/createPost
	 * 입력한 설문조사 내용을 등록하는 메서드
	 * @param srvyVO
	 * @return
	 */
	@PostMapping("/createPost")
	public String createPost(@ModelAttribute SrvyVO srvyVO, HttpServletRequest request,
							RedirectAttributes redirectAttr) {
		// 첨부파일
		int res = this.srvyService.createSurvey(srvyVO);

		if(srvyVO.getUploadFile() != null) {
			int fileRes = this.fileService.srvyFileCreate(srvyVO);
			SrvyVO modifySrvyVO = new SrvyVO();
			modifySrvyVO.setSrvyNo(srvyVO.getSrvyNo());
			modifySrvyVO.setFileGroupNo(srvyVO.getFileGroupNo());
			// 설문조사 테이블에 파일그룹번호 업데이트
			this.srvyService.modifySrvyInfo(modifySrvyVO);
		}


		// 해시태그값
		String[] tagArr = request.getParameterValues("hashTag");
		log.info("tagArr : " + tagArr);

		if(tagArr != null) {
			Map<String,Object> hashTagMap = new HashMap<String, Object>();
			hashTagMap.put("srvyNo",srvyVO.getSrvyNo());
			hashTagMap.put("hashTag",tagArr);
			int hashRes = this.srvyService.createHashTagUse(hashTagMap);
		}

		redirectAttr.addFlashAttribute("resMsg","Success");
		return "redirect:/survey/detail?srvyNo="+srvyVO.getSrvyNo();
	}

	/**
	 * 요청 URI : /localhost/survey/modifyPost
	 * 등록된 설문 수정
	 * @param model
	 * @return
	 */
	@PostMapping("/modifyPost")
	public String modify(SrvyVO srvyVO, Model model)  {
		model.addAttribute("pageMain","Survey");
		model.addAttribute("pageDetail","modify");
		model.addAttribute("pageName","설문조사 수정");

		log.info("srvyVO : " + srvyVO);
		this.srvyService.modifySrvyInfo(srvyVO);

		model.addAttribute("modifySrvyVO",srvyVO);
		return "redirect:/survey/list";
	}

	/**
	 * 요청 URI : /localhost/survey/deleteSrvy
	 * 등록된 설문 삭제
	 * @param srvyVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deleteSrvy")
	public String deleteSrvy(SrvyVO srvyVO) {
		log.info("deleteSrvy srvyVO : " + srvyVO);
		int res = this.srvyService.deleteSrvy(srvyVO);
		String result = "no";
		if(res > 0) {
			result = "ok";
		}
		return result;
	}

	/**
	 * 요청 URI : /localhost/survey/modifySstsSrvy
	 * 설문조사의 상태를 변경하는 메서드
	 * @param srvyVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/modifySstsSrvy")
	public String modifySstsSrvy(SrvyVO srvyVO) {
		int res = this.srvyService.modifySrvyInfo(srvyVO);
		return res + "";
	}

	/**
	 * 요청 URI : /localhost/survey/createRspn
	 * 설문조사 답변을 등록하는 메서드
	 * @param srvyVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/createRspn")
	public String createRspn(SrvyVO srvyVO) {
		int res = 0;
		log.info("srvyVO 1: " + srvyVO);
		String result = "fail";
		for(SrvyRspnVO srvyRspnVO : srvyVO.getSrvyRspnVOList()) {
			res += this.srvyService.createSurveyRspn(srvyRspnVO);
		}
		log.info("srvyVO 2: " + srvyVO);
		if(res > 0) {
			result = "success";
			// insert 성공 시 대상자 수와 답변 수를 비교

			SrvyVO srvyRspnsTrpr = this.srvyService.getTrprRspnsCnt(srvyVO.getSrvyNo());
			log.info("srvyRspnsTrpr 1: " +srvyRspnsTrpr);
			if(srvyRspnsTrpr.getSrvyRspnsCnt().equals(srvyRspnsTrpr.getSrvyTrprCnt())) {
				srvyVO.setSrvySsts("SRVY0003");
				this.srvyService.modifySrvyInfo(srvyVO);
			}
		}
		return result;
	}

	/**
	 * 요청 URI : /localhost/survey/hashTagNmChk
	 * 해시태그 등록 시 중복된 이름이 있는지 검사하는 메서드
	 * @param hashTagListVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/hashTagNmChk")
	public String hashTagNmChk(HashTagListVO hashTagListVO) {
		String res = "use";

		List<HashTagListVO> hashVOList =  this.srvyService.hashTagNmChk(hashTagListVO);
		log.info("hashVOList : " + hashVOList);
		if(hashVOList.size() == 0) {
			res = "ok";
		}
		return res;
	}


	/**
	 * 요청 URI : /localhost/survey/createHashTag
	 * 해시태그를 새로 등록하는 메서드
	 * @param hashTagListVO
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/createHashTag")
	public String createHashTag(HashTagListVO hashTagListVO, RedirectAttributes redirectAttr) {
		log.info("hashTagListVO : " + hashTagListVO);
		int res = this.srvyService.createHashTag(hashTagListVO);

		if(res > 0) {
			redirectAttr.addFlashAttribute("resMsg","해시태그가 추가되었습니다!");
		}
		return "redirect:/admin/srvyManage";
	}

	/**
	 * 요청 URI : /localhost/survey/deleteHashTag
	 * 해시태그를 삭제하는 메서드
	 * @param hashTagListVO
	 * @param redirectAttr
	 * @return
	 */
	@PostMapping("/deleteHashTag")
	public String deleteHashTag(HashTagListVO hashTagListVO, RedirectAttributes redirectAttr) {
		log.info("hashTagListVO : " + hashTagListVO);
		int res = this.srvyService.deleteHashTag(hashTagListVO);

		if(res > 0) {
			redirectAttr.addFlashAttribute("resMsg","해시태그가 삭제되었습니다!");
		}
		return "redirect:/admin/srvyManage";
	}

	/**
	 * 요청 URI : /localhost/survey/modifyUseYn
	 * @param hashTagListVO
	 * @return
	 */
	@PostMapping("/modifyUseYn")
	public String modifyUseYn(HashTagListVO hashTagListVO) {
		log.info("hashTagListVO : " + hashTagListVO);
		this.srvyService.modifyUseYn(hashTagListVO);
		return "redirect:/admin/srvyManage";
	}

	/**
	 * 요청 URI : /localhost/survey/createSrvyCmnt
	 * @param cmntVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/createSrvyCmnt")
	public int createSrvyCmnt(@RequestBody CmntVO cmntVO) {
		int res = 0;

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

	    cmntVO.setEmpNo(empVO.getEmpNo());
		res = this.srvyService.createCmnt(cmntVO);
		return res;
	}
}

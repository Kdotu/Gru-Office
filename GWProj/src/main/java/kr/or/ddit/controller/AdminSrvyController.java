package kr.or.ddit.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
@Controller
@RequestMapping("/admin")
public class AdminSrvyController {

	@Autowired
	SrvyService srvyService;
	@Autowired
	FileService fileService;


	@GetMapping("/srvyMain")
	public String adminSrvyMain(Model model) {
		model.addAttribute("authority","admin");

		return "admin/srvyMain.admin";
	}

	/**
	 * 요청URL : localhost/admin/srvyList
	 * 설문조사 목록을 조회하는 메서드
	 * @param model
	 * @param status
	 * @param currentPage
	 * @param dateArr1
	 * @param dateArr2
	 * @return
	 */
	@GetMapping("/srvyList")
	public String list(Model model,String status,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="dateArr1", required = false) String dateArr1,
			@RequestParam(value="dateArr2", required = false) String dateArr2 ) {
		model.addAttribute("pageMain","AdminSurvey");
		model.addAttribute("pageDetail","list");
		model.addAttribute("pageName","설문조사 목록");
		model.addAttribute("authority","admin");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)auth.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    int size =10;

		log.info("status : " + status);
		Map<String,Object> srvyMap = new HashMap<String, Object>();
		srvyMap.put("empNo",empVO.getEmpNo());
		srvyMap.put("authority","admin");
		srvyMap.put("currentPage",currentPage);
		srvyMap.put("authority","emp");
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
				model.addAttribute("description","전체 설문조사 중 현재 진행중인 설문조사의 목록을 보여줍니다.");
				srvyMap.put("status","progress");
				break;
			case "end": // 마감된 설문
				model.addAttribute("title","마감된 설문");
				model.addAttribute("description","전체 설문조사 중 마감된 설문조사의 목록을 보여줍니다.");
				srvyMap.put("status","end");
				break;
			case "hold": // 보류된 설문
				model.addAttribute("title","보류된 설문");
				model.addAttribute("description","전체 설문조사 중 보류된 목록을 보여줍니다.");
				srvyMap.put("status","hold");
				break;

			default:
				break;
			}
		}

		List<SrvyVO> srvyList = this.srvyService.getAdminSrvyList(srvyMap);
		int total = this.srvyService.getSrvyTotal(srvyMap);

		model.addAttribute("data", new ArticlePage<SrvyVO>(total, currentPage, size, srvyList));
		return "admin/srvyAdminList.admin";
	}

	/**
	 * 요청URL : localhost/admin/srvyDetail
	 * 설문조사 상세 정보를 조회하는 메서드
	 * @param model
	 * @param srvyNo
	 * @return
	 */
	@GetMapping("/srvyDetail")
	public String detail(Model model, String srvyNo) {
		model.addAttribute("authority","admin");
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

		log.info("rspnCntList : " + rspnCntList);
		log.info("srvyQstnVO : " + srvyQstnVO);

		model.addAttribute("trprVOList",trprVOList);
		model.addAttribute("rspnCntList",rspnCntList);
		model.addAttribute("CmntVOList",CmntVOList);
		model.addAttribute("srvyVO",srvyVO);
		model.addAttribute("srvyQstnVO",srvyQstnVO);
		model.addAttribute("srvyRspnVOList",srvyRspnVOList);
		model.addAttribute("hashTagVOList",hashTagVOList);

		return "survey/detail.admin";
	}

	/**
	 * 요청URL : localhost/admin/srvyCreate
	 * 관리자페이지에서 설문조사 등록폼을 불러오는 메서드
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@GetMapping("/srvyCreate")
	public String create(Model model) throws JsonProcessingException {
		model.addAttribute("pageMain","AdminSurvey");
		model.addAttribute("pageDetail","create");
		model.addAttribute("pageName","설문조사 등록");
		model.addAttribute("authority","admin");

		Map<String,String> hashMap = new HashMap<String, String>();
		hashMap.put("useYn","Y");
		List<HashTagListVO> hashTagListVOList = this.srvyService.getHashTagList(hashMap);

		ObjectMapper objMapper = new ObjectMapper();
		String hashTagListVOListStr =objMapper.writeValueAsString(hashTagListVOList);

		log.info("hashTagListVOList : " ,hashTagListVOList);
		log.info("hashTagListVOListStr : " ,hashTagListVOListStr);

		model.addAttribute("hashTagListVOList",hashTagListVOListStr);

		return "survey/create.admin";
	}


	/**
	 * 요청URL : localhost/admin/srvyManage
	 * 설문조사 등록에 사용할 해시태그를 관리하는 페이지
	 *
	 * @param model
	 * @return
	 */
	@GetMapping("/srvyManage")
	public String srvyManage(Model model) {
		model.addAttribute("pageMain","AdminSurvey");
		model.addAttribute("pageDetail","manage");
		model.addAttribute("pageName","해시태그 관리");
		model.addAttribute("authority","admin");
		Map<String,String> hashMap = new HashMap<String, String>();

		List<HashTagListVO> hashTagListVOList = this.srvyService.getHashTagList(hashMap);
		model.addAttribute("hashTagListVOList",hashTagListVOList);

		return "admin/srvyManage.admin";
	}

	/**
	 * 요청URL : localhost/admin/createSrvyAdminCmnt
	 * 관리자페이지에서 설문조사에 댓글을 작성하는 메서드
	 * 다른 계정으로 로그인해도 기업 관리자의 아이디로 기록
	 * @param cmntVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/createSrvyAdminCmnt")
	public int createSrvyCmnt(@RequestBody CmntVO cmntVO) {
		int res = 0;
	    cmntVO.setEmpNo("202300");
		res = this.srvyService.createCmnt(cmntVO);
		return res;
	}

}

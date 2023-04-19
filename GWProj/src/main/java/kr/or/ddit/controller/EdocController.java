package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.EdocService;
import kr.or.ddit.vo.AtrzLineInfoVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/edoc")
@Controller
public class EdocController {

	 @Autowired
	 EdocService edocService;

	/** 요청 URI : /localhost/edoc/main
	 * 전자결재 메인 페이지
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String main(Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","main");
		model.addAttribute("pageName","전자결재 메인");

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    empVO.getEmpNo();

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);
		pagingVO.setEmpNo(empVO.getEmpNo());

		//기안한문서의 개수
		int drafting = this.edocService.getDraftingTotal(pagingVO);
		model.addAttribute("drafting",drafting);

		//결재할 문서의개수
		int approve = this.edocService.getApproveTotal(pagingVO);
		model.addAttribute("approve", approve);

		//결재 진행 문서의 개수 개수
		int approved = this.edocService.getApprovedTotal(pagingVO);
		model.addAttribute("approved", approved);

		//반려문서함 문서의 개수
		int reject = this.edocService.getRejectTotal(pagingVO);
		model.addAttribute("reject", reject);

		//참조문서함의 문서의 개수
		int atrzRfrnc = this.edocService.getAtrzRfrncTotal(pagingVO);
		model.addAttribute("atrzRfrnc",atrzRfrnc);


		//결재할 문서 list가져오기
		PaginationInfoVO<AtrzLineInfoVO> pagingVO2 = new PaginationInfoVO<AtrzLineInfoVO>(4,5);
		pagingVO2.setEmpNo(empVO.getEmpNo());
		int totalRecord = this.edocService.getApproveTotal(pagingVO2);
		pagingVO2.setTotalRecord(totalRecord);
		pagingVO2.setCurrentPage(1);
		pagingVO2.setScreenSize(4);
		List<Map<String,Object>> dataMapList = this.edocService.getApprove(pagingVO2);
		pagingVO2.setDataMapList(dataMapList);
		model.addAttribute("pagingVO2",pagingVO2);


		//결재 진행 문서 list 가져오기
		PaginationInfoVO<AtrzLineInfoVO> pagingVO3 = new PaginationInfoVO<AtrzLineInfoVO>(5,5);
		pagingVO3.setCurrentPage(1);
	    pagingVO3.setEmpNo(empVO.getEmpNo());
	    empVO.getEmpNo();
		int totalRecord3 = this.edocService.getApprovedTotal(pagingVO3);
		pagingVO3.setTotalRecord(totalRecord3);
		List<Map<String,Object>> dataMapList3 = this.edocService.getApproved(pagingVO3);
		pagingVO3.setDataMapList(dataMapList3);
		model.addAttribute("pagingVO3",pagingVO3);
		return "edoc/main";
	}



	/**  요청 URI : /localhost/edoc/drft
	 * 휴가기안서를 제외한 모든 기안서를 가져오는 메서드
	 * @param form
	 * @param model
	 * @return
	 */
	@GetMapping("/drft")
	public String drft(@RequestParam("form") String form,Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
		model.addAttribute("title",form);
		model.addAttribute("name",empVO.getEmpNm());
		model.addAttribute("dept",empVO.getDeptNm());
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		model.addAttribute("today",today);
		model.addAttribute("me",empVO.getEmpNo());
		return "edoc/drft.empty2";
	}



	/** 요청 URI : /localhost/edoc/holi
	 * 휴가기안서를 가져오는 메서드
	 * @param model
	 * @return
	 */
	@GetMapping("/holi")
	public String holi(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
		model.addAttribute("name",empVO.getEmpNm());
		model.addAttribute("dept",empVO.getDeptNm());
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(date);
		model.addAttribute("today",today);
		model.addAttribute("me",empVO.getEmpNo());
		return "edoc/holi.empty2";
	}


	/** 요청 URI : /localhost/edoc/edocPost
	 * 기안서를 insert하는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	@PostMapping("/edocPost")
	public String edocPost(@ModelAttribute AtrzLineInfoVO atrzLineInfoVO) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    atrzLineInfoVO.getEdocVO().setEmpNo(empVO.getEmpNo());

		int result = this.edocService.createEdocPost(atrzLineInfoVO);
		String edocNo = atrzLineInfoVO.getEdocVO().getEdocNo();
		String form = atrzLineInfoVO.getEdocVO().getEdocFormClsf();
		return "redirect:/edoc/edocDetail?edocVO.edocNo="+edocNo+"&edocVO.edocFormClsf="+form+"&approve=3";
	}


	/** 요청 URI : /localhost/edoc/draftingBox
	 * 로그인 한 사원의 기안한 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/draftingBox")
	public String draftingBox(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage,
			@RequestParam(required=false, defaultValue="edocTtl") String searchType,
			@RequestParam(required=false) String searchWord,
			HttpServletRequest req, Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","approve");
		model.addAttribute("pageName","기안한 문서");

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);
		// 검색기능
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());
	    empVO.getEmpNo();

		int totalRecord = this.edocService.getDraftingTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<Map<String,Object>> dataMapList = this.edocService.getDrafting(pagingVO);
		pagingVO.setDataMapList(dataMapList);

		model.addAttribute("pagingVO",pagingVO);
		return "edoc/draftingBox";
	}



	/** 요청 URI : /localhost/edoc/draftingBox
	 * 결재할 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/approve")
	public String approve(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage,
			@RequestParam(required=false, defaultValue="edocTtl") String searchType,
			@RequestParam(required=false) String searchWord,
			HttpServletRequest req, Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","approve");
		model.addAttribute("pageName","결재할 문서");

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);
		//검색기능
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());

		int totalRecord = this.edocService.getApproveTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<Map<String,Object>> dataMapList = this.edocService.getApprove(pagingVO);
		pagingVO.setDataMapList(dataMapList);
		model.addAttribute("pagingVO",pagingVO);
		return "edoc/approve";
	}


	/** 요청 URI : /localhost/edoc/approved
	 * 결재 진행 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/approved")
	public String approved(@RequestParam(name="page", required=false, defaultValue="1") int currentPage,
			@RequestParam(required=false, defaultValue="edocTtl") String searchType,
			@RequestParam(required=false) String searchWord,
			HttpServletRequest req, Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","approved");
		model.addAttribute("pageName","결재진행 문서");

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);
		//검색기능
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}
		pagingVO.setCurrentPage(currentPage);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());
	    empVO.getEmpNo();

		int totalRecord = this.edocService.getApprovedTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<Map<String,Object>> dataMapList = this.edocService.getApproved(pagingVO);
		pagingVO.setDataMapList(dataMapList);
		model.addAttribute("pagingVO",pagingVO);

		return "edoc/approved";
	}


	/** 요청 URI : /localhost/edoc/rejectBox
	 * 반려 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/rejectBox")
	public String storageBox(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
							@RequestParam(required=false, defaultValue="edocTtl") String searchType,
							@RequestParam(required=false) String searchWord,HttpServletRequest req,Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","rejectBox");
		model.addAttribute("pageName","반려문서함");


		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);

		//검색
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}

			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());

		int totalRecord = this.edocService.getRejectTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<Map<String,Object>> dataMapList = this.edocService.getRejectBox(pagingVO);
 		pagingVO.setDataMapList(dataMapList);
 		model.addAttribute("pagingVO",pagingVO);

		return "edoc/rejectBox";
	}


	/** 요청 URI : /localhost/edoc/atrzRfrnc
	 * 자신이 참조된 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/atrzRfrnc")
	public String atrzRfrnc(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
							@RequestParam(required=false, defaultValue="edocTtl") String searchType,
							@RequestParam(required=false) String searchWord,HttpServletRequest req,Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","references");
		model.addAttribute("pageName","참조문서함");

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);

		//검색
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}

			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());

		int totalRecord = this.edocService.getAtrzRfrncTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<Map<String,Object>> dataMapList = this.edocService.getAtrzRfrncBox(pagingVO);
 		pagingVO.setDataMapList(dataMapList);
 		model.addAttribute("pagingVO",pagingVO);
		return "edoc/atrzRfrnc";
	}


	/** 요청 URI : /localhost/edoc/completeBox
	 * 결재가 완료된 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/completeBox")
	public String completeBox(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			@RequestParam(required=false, defaultValue="edocTtl") String searchType,
			@RequestParam(required=false) String searchWord,HttpServletRequest req,Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","completeBox");
		model.addAttribute("pageName","결재완료문서함");

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);

		//검색
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}

		pagingVO.setCurrentPage(currentPage);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());

		int totalRecord = this.edocService.getCompleteTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<Map<String,Object>> dataMapList = this.edocService.getCompleteBox(pagingVO);
 		pagingVO.setDataMapList(dataMapList);
 		model.addAttribute("pagingVO",pagingVO);
		return "edoc/completeBox";
	}



	/** 요청 URI : /localhost/edoc/atrzRfrncCompleteBox
	 * 참조 완료 문서 리스트를 가져오는 메서드
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param req
	 * @param model
	 * @return
	 */
	@GetMapping("/atrzRfrncCompleteBox")
	public String atrzRfrncCompleteBox(@RequestParam(name="page",required=false,defaultValue="1") int currentPage,
			@RequestParam(required=false, defaultValue="edocTtl") String searchType,
			@RequestParam(required=false) String searchWord,HttpServletRequest req,Model model) {
		model.addAttribute("pageMain","Edoc");
		model.addAttribute("pageDetail","completeBox");
		model.addAttribute("pageName","참조완료문서함");

		PaginationInfoVO<AtrzLineInfoVO> pagingVO = new PaginationInfoVO<AtrzLineInfoVO>(5,5);

		//검색
		if(StringUtils.isNotBlank(searchWord)) {
			if("edocTtl".equals(searchType)) {
				pagingVO.setSearchType("edocTtl");
			}else{
				pagingVO.setSearchType("empNm");
			}
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}
		pagingVO.setCurrentPage(currentPage);

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    pagingVO.setEmpNo(empVO.getEmpNo());

		int totalRecord = this.edocService.getAtrzRfrncCompleteTotal(pagingVO);
		pagingVO.setTotalRecord(totalRecord);

		List<Map<String,Object>> dataMapList = this.edocService.getAtrzRfrncCompleteBox(pagingVO);
 		pagingVO.setDataMapList(dataMapList);
 		model.addAttribute("pagingVO",pagingVO);
		return "edoc/atrzRfrncCompleteBox";
	}


	/** 요청 URI : /localhost/edoc/edocFormSelect
	 * 기안서 선택 메서드
	 * @return
	 */
	@GetMapping("/edocFormSelect")
	public String edocFormSelect() {
		return "treeview/demo/edocFormSelect";
	}


	/** 휴가기안문에 잔여휴일의 정보를 가져오는 메서드
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getCtrHoli")
	public int getCtrHoly() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
		int ctrHoli = this.edocService.getCtrHoli(empVO);
		return ctrHoli;
	}


	/** 결재 정보 및 결재상황을 가져오는 메서드
	 * @param edocNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getAtrz")
	public List<Map<String,Object>> getAtrz(String edocNo){
		List<Map<String,Object>> list = this.edocService.getAtrz(edocNo);
		return list;
	}


	/** 요청 URL : /localhost/edoc/edocDetail
	 * 기안서를 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @param approve
	 * @param model
	 * @param rab
	 * @return
	 */
	@GetMapping("/edocDetail")
	public String holiDetail(@ModelAttribute AtrzLineInfoVO atrzLineInfoVO,@RequestParam("approve") String approve,
								Model model,RedirectAttributes rab)  {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

	    //기안자 정보
		Map<String,Object> empInfo = this.edocService.getEmpInfo(atrzLineInfoVO);

		//휴가기안서 detail 가져오기
		if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM06")) {
			List<AtrzLineInfoVO> list = this.edocService.holiDetail(atrzLineInfoVO);

			model.addAttribute("list", list.get(0));
			model.addAttribute("empInfo",empInfo);
			model.addAttribute("empVO",empVO);
			model.addAttribute("approve",approve); //1이면 결재 보이게, 2면 공람 3이면 아무것도 안보이게
			return "edoc/holiDetail.empty2";
		}

		//일반기안서 detail 가져오기
		if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM01") || atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM03")
				|| atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM04") || atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM05")
				|| atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM07")) {
			List<AtrzLineInfoVO> list = this.edocService.drftDetail(atrzLineInfoVO);
			model.addAttribute("list",list.get(0));
			model.addAttribute("empInfo",empInfo);
			model.addAttribute("approve",approve); //ok면 결재 보이게, no면 결재안보이게

			if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM01")) {
				model.addAttribute("form","업 무 기 안");
			}
			if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM03")) {
				model.addAttribute("form","증명서신청");
			}
			if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM04")) {
				model.addAttribute("form","품의서");
			}
			if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM05")) {
				model.addAttribute("form","지출결의서");
			}
			if(atrzLineInfoVO.getEdocVO().getEdocFormClsf().equals("EDOCFORM07")) {
				model.addAttribute("form","법인카드사용신청서");
			}
			model.addAttribute("approve",approve); //1이면 결재 보이게, 2면 공람/ 3이면 아무것도 안보이게
			return "edoc/drftDetail.empty2";
		}
		return "edoc/main";
	}



	/** 요청 URL : /localhost/edoc/updateEdoc
	 * 재기안 페이지로 이동
	 * @param atrzLineInfoVO
	 * @param approve
	 * @param model
	 * @return
	 */
	@GetMapping("/updateEdoc")
	public String updateEdoc(@ModelAttribute AtrzLineInfoVO atrzLineInfoVO,@RequestParam("approve") String approve,Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();

	    //기안자 정보
		Map<String,Object> empInfo = this.edocService.getEmpInfo(atrzLineInfoVO);
		String formStyle = atrzLineInfoVO.getEdocVO().getEdocFormClsf();

		//휴가신청서
		if(formStyle.equals("EDOCFORM06")) {
			List<AtrzLineInfoVO> list = this.edocService.holiDetail(atrzLineInfoVO);
			model.addAttribute("list", list.get(0));
			model.addAttribute("name",empVO.getEmpNm());
			model.addAttribute("dept",empVO.getDeptNm());
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(date);
			model.addAttribute("today",today);
			model.addAttribute("approve",approve); //1이면 결재 보이게, 2면 공람 3이면 아무것도 안보이게
			return "edoc/holiUpdate.empty2";

		}

		//일반기안서 update 가져오기(/edoc/updateEdoc?edocVO.edocNo=EDOC016&edocVO.edocFormClsf=EDOCFORM01&approve=3")
		if(formStyle.equals("EDOCFORM01") || formStyle.equals("EDOCFORM03")
				|| formStyle.equals("EDOCFORM04") || formStyle.equals("EDOCFORM05")
				|| formStyle.equals("EDOCFORM07")) {
			List<AtrzLineInfoVO> list = this.edocService.drftDetail(atrzLineInfoVO);
			if(formStyle.equals("EDOCFORM01")) {
				model.addAttribute("form","업 무 기 안");
			}
			if(formStyle.equals("EDOCFORM03")) {
				model.addAttribute("form","증명서신청");
			}
			if(formStyle.equals("EDOCFORM04")) {
				model.addAttribute("form","품의서");
			}
			if(formStyle.equals("EDOCFORM05")) {
				model.addAttribute("form","지출결의서");
			}
			if(formStyle.equals("EDOCFORM07")) {
				model.addAttribute("form","법인카드사용신청서");
			}

			model.addAttribute("name",empVO.getEmpNm());
			model.addAttribute("dept",empVO.getDeptNm());
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(date);
			model.addAttribute("today",today);
			model.addAttribute("list",list.get(0));
			model.addAttribute("empInfo",empInfo);
			model.addAttribute("approve",approve);
			return "edoc/drftUpdate.empty2";
		}

		return "edoc/main";
	}



	/** 참조자정보를 가져오는 메서드
	 * @param edocNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/getAtrzRfrnc")
	public List<Map<String,Object>> getAtrzRfrnc(String edocNo) {
		List<Map<String,Object>> list = this.edocService.getAtrzRfrnc(edocNo);
		return list;
	}


	/** 기안서를 결재하는 메소드
	 * @return 성공시 1 실패시 0
	 */
	@ResponseBody
	@PostMapping(value="/approval", produces = "application/json")
	public int approval(@RequestBody Map<String, Object> infoData) {
		log.info("infoData : "+infoData);
		int result = this.edocService.updateAtrz(infoData);
		return result;
	}


	/** 기안서를 반려하는 메서드
	 * @param infoData
	 * @return 성공시 1 실패시 0
	 */
	@ResponseBody
	@PostMapping(value="/reject", produces = "application/json")
	public int reject(@RequestBody Map<String, Object> infoData) {
		int result = this.edocService.rejectAtrz(infoData);
		return result;
	}


	/** 반려의견을 가져오는 메서드
	 * @param infoData
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/getRjctRsn", produces = "application/json")
	public Map<String,Object> getRjctRsn(@RequestBody Map<String, Object> infoData) {
		Map<String, Object> map = this.edocService.getRjctRsn(infoData);
		return map;
	}



	/** 반려된 문서를 삭제하는 메서드
	 * @param edocNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deleteEdoc")
	public int deleteEdoc(@RequestBody String edocNo) {
		edocNo=edocNo.replaceAll("=", "");
		int result = this.edocService.deleteEdoc(edocNo);
		return result;
	}


	/** 요청 URI : /localhost/edoc/edocUpdatePost
	 * 재기안 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	@PostMapping("/edocUpdatePost")
	public String edocUpdatePost(@ModelAttribute AtrzLineInfoVO atrzLineInfoVO) {
		int result = this.edocService.edocUpdatePost(atrzLineInfoVO);
		String edocNo = atrzLineInfoVO.getEdocVO().getEdocNo();
		String form = atrzLineInfoVO.getEdocVO().getEdocFormClsf();
		return "redirect:/edoc/edocDetail?edocVO.edocNo="+edocNo+"&edocVO.edocFormClsf="+form+"&approve=3";
	}


	/** 요청 URI : /localhost/edoc/atrzRfrncY
	 * 참조 완료 처리 메서드
	 * @param infoData
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/atrzRfrncY", produces = "application/json")
	public int atrzRfrncY(@RequestBody Map<String, Object> infoData) {
		int result = this.edocService.atrzRfrncY(infoData);
		return result;
	}


}

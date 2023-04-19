package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
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

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.ArchiveService;
import kr.or.ddit.vo.ArchiveVO;
import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/archive")
public class ArchiveController {

	@Autowired
	ArchiveService archiveService;

/** 요청URL : /localhost/archive/bookmark
 * 즐겨찾기 한 자료를 가져오는 메서드
 * @param currentPage
 * @param searchType
 * @param searchWord
 * @param model
 * @param request
 * @return
 */
@GetMapping("/bookmark")
   public String bookmarkArchive(@RequestParam(name="page",required=false,defaultValue = "1") int currentPage,
								   @RequestParam(required=false, defaultValue = "arcOrgnlNm") String searchType,
								   @RequestParam(required=false) String searchWord,Model model,
								   HttpServletRequest request) {
      model.addAttribute("pageMain","Archive");
      model.addAttribute("pageDetail","bookmark");
      model.addAttribute("pageName","즐겨찾는 자료실");

	   PaginationInfoVO<ArchiveVO> pagingVO = new PaginationInfoVO<ArchiveVO>(8,3);

	   //검색기능추가시 활용
	   if(StringUtils.isNotBlank(searchWord)) {
		   if("arcOrgnlNm".equals(searchType)) {
			   pagingVO.setSearchType("arcOrgnlNm");
		   }else {
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
	   String empNo = empVO.getEmpNo();
	   pagingVO.setEmpNo(empVO.getEmpNo());


	   int totalRecord = this.archiveService.getBookmarkTotal(pagingVO);
	   pagingVO.setTotalRecord(totalRecord);

	   List<Map<String,Object>> dataMapList =  this.archiveService.getBookmark(pagingVO);
	   pagingVO.setDataMapList(dataMapList);

	   //개인자료실 사용량
	   int personalSize = this.archiveService.getPersonalUsage(empNo);

	   //부서자료실 사용량
	   int deptSize = this.archiveService.getDeptUsage(empNo);

	   //공용자료실 사용량
	   int publicSize = this.archiveService.getpublicUsage();

	   Map<String,Integer> mapAchive = new HashMap<String, Integer>();
	   mapAchive.put("personalSize", personalSize);
	   mapAchive.put("deptSize", deptSize);
	   mapAchive.put("publicSize", publicSize);
	   model.addAttribute("pagingVO", pagingVO);

	   //이미지 개수 및 총 용량 가져오기
	   Map<String,Object> param = new HashMap<>();
	   param.put("empNo", empNo);
	   param.put("parameter","image");

	   //개인자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> personalImage = this.archiveService.personalImage(param);
	   int personalCount = Integer.parseInt(String.valueOf(personalImage.get("COUNT")));
	   int personalImageUsage = Integer.parseInt(String.valueOf(personalImage.get("PERSONALIMAGE")));

	   //부서자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> deptImage = this.archiveService.deptImage(empNo);

	   int deptImageCount = Integer.parseInt(String.valueOf(deptImage.get("COUNT")));
	   int deptImageUsage = Integer.parseInt(String.valueOf(deptImage.get("DEPTIMAGE")));

	   //공용자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> publicImage = this.archiveService.publicImage();
	   int publicImageCount = Integer.parseInt(String.valueOf(publicImage.get("COUNT")));
	   int publicImageUsage = Integer.parseInt(String.valueOf(publicImage.get("PUBLICIMAGE")));

	   int ImageCount =personalCount + deptImageCount + publicImageCount;
	   int ImageUsage = personalImageUsage + deptImageUsage+ publicImageUsage;

	   mapAchive.put("ImageCount",ImageCount);
	   mapAchive.put("ImageUsage",ImageUsage);

	   //문서개수 및 용량
	   Map<String,Object> personalDoc = this.archiveService.personalDoc(empNo);
	   int personalDocCount = Integer.parseInt(String.valueOf(personalDoc.get("COUNT")));
	   int personalDocUsage = Integer.parseInt(String.valueOf(personalDoc.get("PERSONALDOC")));

	   Map<String,Object> deptDoc = this.archiveService.deptDoc(empNo);
	   int deptDocCount = Integer.parseInt(String.valueOf(deptDoc.get("COUNT")));
	   int deptDocUsage = Integer.parseInt(String.valueOf(deptDoc.get("DEPTDOC")));

	   Map<String,Object> publicDoc = this.archiveService.publicDoc();
	   int publicDocCount = Integer.parseInt(String.valueOf(publicDoc.get("COUNT")));
	   int publicDocUsage = Integer.parseInt(String.valueOf(publicDoc.get("PUBLICDOC")));

	   int docCount = personalDocCount + deptDocCount + publicDocCount;
	   int docUsage = personalDocUsage + deptDocUsage + publicDocUsage;

	   mapAchive.put("docCount",docCount);
	   mapAchive.put("docUsage",docUsage);

	   //미디어 개수 및 용량
	   Map<String,Object> personalMedia = this.archiveService.personalMedia(empNo);
	   int personalMediaCount = Integer.parseInt(String.valueOf(personalMedia.get("COUNT")));
	   int personalMideaUsage = Integer.parseInt(String.valueOf(personalMedia.get("PERSONALMEDIA")));

	   Map<String,Object> deptMedia = this.archiveService.deptMedia(empNo);
	   int deptMediaCount = Integer.parseInt(String.valueOf(deptMedia.get("COUNT")));
	   int deptMideaUsage = Integer.parseInt(String.valueOf(deptMedia.get("DEPTMEDIA")));

	   Map<String,Object> publicMedia = this.archiveService.publictMedia();
	   int publicMediaCount = Integer.parseInt(String.valueOf(publicMedia.get("COUNT")));
	   int publicMideaUsage = Integer.parseInt(String.valueOf(publicMedia.get("PUBLICMEDIA")));

	   int mediaCount = personalMediaCount + deptMediaCount + publicMediaCount;
	   int mediaUsage = personalMideaUsage + deptMideaUsage + publicMideaUsage;

	   mapAchive.put("mediaCount", mediaCount);
	   mapAchive.put("mediaUsage", mediaUsage);

	   model.addAttribute("mapAchive", mapAchive);
      return "archive/bookmark";
   }



   /** 요청URL : /localhost/archive/personal
    * 로그인 한 사원의 개인자료실의 자료(파일)를 가져오는 메서드
 * @param currentPage
 * @param searchType
 * @param searchWord
 * @param model
 * @return
 */
@GetMapping("/personal")
   public String personalArchive(
		   @RequestParam(name="page",required=false,defaultValue = "1") int currentPage,
		   @RequestParam(required=false, defaultValue = "arcOrgnlNm") String searchType,
		   @RequestParam(required = false) String searchWord,
		   Model model) {
	   model.addAttribute("pageMain","Archive");
	   model.addAttribute("pageDetail","personal");
	   model.addAttribute("pageName","개인자료실");

	   PaginationInfoVO<ArchiveVO> pagingVO = new PaginationInfoVO<ArchiveVO>(8,3);

	   //검색기능 추가시 활용
	   if(StringUtils.isNotBlank(searchWord)) {
		   if("arcOrgnlNm".equals(searchType)) {
			   pagingVO.setSearchType("arcOrgnlNm");
		   }else {
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
	   String empNo = empVO.getEmpNo();
	   pagingVO.setEmpNo(empVO.getEmpNo());


	   int totalRecord = this.archiveService.getPersonalTotal(pagingVO);
	   pagingVO.setTotalRecord(totalRecord);

	   List<Map<String,Object>> dataMapList =  this.archiveService.getPersonal(pagingVO);
	   pagingVO.setDataMapList(dataMapList);

	   model.addAttribute("pagingVO", pagingVO);

	   //개인자료실 사용량
	   int personalSize = this.archiveService.getPersonalUsage(empNo);
	   //부서자료실 사용량
	   int deptSize = this.archiveService.getDeptUsage(empNo);
	   //공용자료실 사용량
	   int publicSize = this.archiveService.getpublicUsage();

	   Map<String,Integer> mapAchive = new HashMap<String, Integer>();
	   mapAchive.put("personalSize", personalSize);
	   mapAchive.put("deptSize", deptSize);
	   mapAchive.put("publicSize", publicSize);

	 //이미지 개수 및 총 용량 가져오기
	   Map<String,Object> param = new HashMap<>();
	   param.put("empNo", empNo);
	   param.put("parameter","image");

	   //개인자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> personalImage = this.archiveService.personalImage(param);
	   int personalCount = Integer.parseInt(String.valueOf(personalImage.get("COUNT")));
	   int personalImageUsage = Integer.parseInt(String.valueOf(personalImage.get("PERSONALIMAGE")));

	   //부서자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> deptImage = this.archiveService.deptImage(empNo);
	   int deptImageCount = Integer.parseInt(String.valueOf(deptImage.get("COUNT")));
	   int deptImageUsage = Integer.parseInt(String.valueOf(deptImage.get("DEPTIMAGE")));

	   //공용자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> publicImage = this.archiveService.publicImage();
	   int publicImageCount = Integer.parseInt(String.valueOf(publicImage.get("COUNT")));
	   int publicImageUsage = Integer.parseInt(String.valueOf(publicImage.get("PUBLICIMAGE")));
	   int ImageCount =personalCount + deptImageCount + publicImageCount;
	   int ImageUsage = personalImageUsage + deptImageUsage+ publicImageUsage;

	   mapAchive.put("ImageCount",ImageCount);
	   mapAchive.put("ImageUsage",ImageUsage);

	   //문서개수 및 용량
	   Map<String,Object> personalDoc = this.archiveService.personalDoc(empNo);
	   int personalDocCount = Integer.parseInt(String.valueOf(personalDoc.get("COUNT")));
	   int personalDocUsage = Integer.parseInt(String.valueOf(personalDoc.get("PERSONALDOC")));

	   Map<String,Object> deptDoc = this.archiveService.deptDoc(empNo);
	   int deptDocCount = Integer.parseInt(String.valueOf(deptDoc.get("COUNT")));
	   int deptDocUsage = Integer.parseInt(String.valueOf(deptDoc.get("DEPTDOC")));

	   Map<String,Object> publicDoc = this.archiveService.publicDoc();
	   int publicDocCount = Integer.parseInt(String.valueOf(publicDoc.get("COUNT")));
	   int publicDocUsage = Integer.parseInt(String.valueOf(publicDoc.get("PUBLICDOC")));

	   int docCount = personalDocCount + deptDocCount + publicDocCount;
	   int docUsage = personalDocUsage + deptDocUsage + publicDocUsage;

	   mapAchive.put("docCount",docCount);
	   mapAchive.put("docUsage",docUsage);

	   //미디어 개수 및 용량
	   Map<String,Object> personalMedia = this.archiveService.personalMedia(empNo);
	   int personalMediaCount = Integer.parseInt(String.valueOf(personalMedia.get("COUNT")));
	   int personalMideaUsage = Integer.parseInt(String.valueOf(personalMedia.get("PERSONALMEDIA")));

	   Map<String,Object> deptMedia = this.archiveService.deptMedia(empNo);
	   int deptMediaCount = Integer.parseInt(String.valueOf(deptMedia.get("COUNT")));
	   int deptMideaUsage = Integer.parseInt(String.valueOf(deptMedia.get("DEPTMEDIA")));

	   Map<String,Object> publicMedia = this.archiveService.publictMedia();
	   int publicMediaCount = Integer.parseInt(String.valueOf(publicMedia.get("COUNT")));
	   int publicMideaUsage = Integer.parseInt(String.valueOf(publicMedia.get("PUBLICMEDIA")));
	   int mediaCount = personalMediaCount + deptMediaCount + publicMediaCount;
	   int mediaUsage = personalMideaUsage + deptMideaUsage + publicMideaUsage;

	   mapAchive.put("mediaCount", mediaCount);
	   mapAchive.put("mediaUsage", mediaUsage);
	   model.addAttribute("mapAchive", mapAchive);
	   return "archive/personal";
   }

   /** 요청 URI : /localhost/archive/dept
    * 내가 속한 부서의 자료를 가져오는 메서드(부서자료실)
 * @param currentPage
 * @param searchType
 * @param searchWord
 * @param model
 * @return
 */
@GetMapping("/dept")
   public String deptArchive(@RequestParam(name="page",required=false,defaultValue = "1") int currentPage,
							   @RequestParam(required=false, defaultValue = "arcOrgnlNm") String searchType,
							   @RequestParam(required = false) String searchWord,
							   Model model) {
      model.addAttribute("pageMain","Archive");
      model.addAttribute("pageDetail","dept");
      model.addAttribute("pageName","부서자료실");

      PaginationInfoVO<ArchiveVO> pagingVO = new PaginationInfoVO<ArchiveVO>(8,3);

	   //검색기능추가시 활용
	   if(StringUtils.isNotBlank(searchWord)) {
		   if("arcOrgnlNm".equals(searchType)) {
			   pagingVO.setSearchType("arcOrgnlNm");
		   }else {
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
	   String empNo = empVO.getEmpNo();
	   pagingVO.setEmpNo(empVO.getEmpNo());

	   int totalRecord = this.archiveService.getDeptTotal(pagingVO);
	   pagingVO.setTotalRecord(totalRecord);

	   List<Map<String,Object>> dataMapList =  this.archiveService.getDept(pagingVO);
	   pagingVO.setDataMapList(dataMapList);

	   model.addAttribute("pagingVO", pagingVO);

	   //개인자료실 사용량
	   int personalSize = this.archiveService.getPersonalUsage(empNo);

	   log.info("개인사용량" +personalSize);

	   //부서자료실 사용량
	   int deptSize = this.archiveService.getDeptUsage(empNo);
	   log.info("부서사용량"+deptSize);

	   //공용자료실 사용량
	   int publicSize = this.archiveService.getpublicUsage();
	   log.info("공용사용량" +publicSize);

	   Map<String,Integer> mapAchive = new HashMap<String, Integer>();
	   mapAchive.put("personalSize", personalSize);
	   mapAchive.put("deptSize", deptSize);
	   mapAchive.put("publicSize", publicSize);

	 //이미지 개수 및 총 용량 가져오기
	   Map<String,Object> param = new HashMap<>();
	   param.put("empNo", empNo);
	   param.put("parameter","image");

	   //개인자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> personalImage = this.archiveService.personalImage(param);
	   int personalCount = Integer.parseInt(String.valueOf(personalImage.get("COUNT")));
	   int personalImageUsage = Integer.parseInt(String.valueOf(personalImage.get("PERSONALIMAGE")));

	   //부서자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> deptImage = this.archiveService.deptImage(empNo);

	   int deptImageCount = Integer.parseInt(String.valueOf(deptImage.get("COUNT")));
	   int deptImageUsage = Integer.parseInt(String.valueOf(deptImage.get("DEPTIMAGE")));

	   //공용자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> publicImage = this.archiveService.publicImage();
	   int publicImageCount = Integer.parseInt(String.valueOf(publicImage.get("COUNT")));
	   int publicImageUsage = Integer.parseInt(String.valueOf(publicImage.get("PUBLICIMAGE")));


	   int ImageCount =personalCount + deptImageCount + publicImageCount;
	   int ImageUsage = personalImageUsage + deptImageUsage+ publicImageUsage;

	   mapAchive.put("ImageCount",ImageCount);
	   mapAchive.put("ImageUsage",ImageUsage);

	   //문서개수 및 용량
	   Map<String,Object> personalDoc = this.archiveService.personalDoc(empNo);
	   int personalDocCount = Integer.parseInt(String.valueOf(personalDoc.get("COUNT")));
	   int personalDocUsage = Integer.parseInt(String.valueOf(personalDoc.get("PERSONALDOC")));

	   Map<String,Object> deptDoc = this.archiveService.deptDoc(empNo);
	   int deptDocCount = Integer.parseInt(String.valueOf(deptDoc.get("COUNT")));
	   int deptDocUsage = Integer.parseInt(String.valueOf(deptDoc.get("DEPTDOC")));

	   Map<String,Object> publicDoc = this.archiveService.publicDoc();
	   int publicDocCount = Integer.parseInt(String.valueOf(publicDoc.get("COUNT")));
	   int publicDocUsage = Integer.parseInt(String.valueOf(publicDoc.get("PUBLICDOC")));

	   int docCount = personalDocCount + deptDocCount + publicDocCount;
	   int docUsage = personalDocUsage + deptDocUsage + publicDocUsage;

	   mapAchive.put("docCount",docCount);
	   mapAchive.put("docUsage",docUsage);

	   //미디어 개수 및 용량
	   Map<String,Object> personalMedia = this.archiveService.personalMedia(empNo);
	   int personalMediaCount = Integer.parseInt(String.valueOf(personalMedia.get("COUNT")));
	   int personalMideaUsage = Integer.parseInt(String.valueOf(personalMedia.get("PERSONALMEDIA")));

	   Map<String,Object> deptMedia = this.archiveService.deptMedia(empNo);
	   int deptMediaCount = Integer.parseInt(String.valueOf(deptMedia.get("COUNT")));
	   int deptMideaUsage = Integer.parseInt(String.valueOf(deptMedia.get("DEPTMEDIA")));

	   Map<String,Object> publicMedia = this.archiveService.publictMedia();
	   int publicMediaCount = Integer.parseInt(String.valueOf(publicMedia.get("COUNT")));
	   int publicMideaUsage = Integer.parseInt(String.valueOf(publicMedia.get("PUBLICMEDIA")));

	   int mediaCount = personalMediaCount + deptMediaCount + publicMediaCount;
	   int mediaUsage = personalMideaUsage + deptMideaUsage + publicMideaUsage;

	   mapAchive.put("mediaCount", mediaCount);
	   mapAchive.put("mediaUsage", mediaUsage);
	   model.addAttribute("mapAchive", mapAchive);

	  return "archive/dept";
   }


   /** 요청 URI : /localhost/archive/public
    * 공용자료실의 자료를 가져오는 메서드
 * @param currentPage
 * @param searchType
 * @param searchWord
 * @param model
 * @return
 */
@GetMapping("/public")
   public String publicArchive(@RequestParam(name="page",required=false,defaultValue = "1") int currentPage,
							   @RequestParam(required=false, defaultValue = "arcOrgnlNm") String searchType,
							   @RequestParam(required = false) String searchWord, Model model) {
	   model.addAttribute("pageMain","Archive");
	   model.addAttribute("pageDetail","public");
	   model.addAttribute("pageName","공용자료실");

	   PaginationInfoVO<ArchiveVO> pagingVO = new PaginationInfoVO<ArchiveVO>(8,3);

	   //검색기능추가시 활용
	   if(StringUtils.isNotBlank(searchWord)) {
		   if("arcOrgnlNm".equals(searchType)) {
			   pagingVO.setSearchType("arcOrgnlNm");
		   }else {
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
	   String empNo = empVO.getEmpNo();
	   pagingVO.setEmpNo(empVO.getEmpNo());

	   int totalRecord = this.archiveService.getPublicTotal(pagingVO);
	   pagingVO.setTotalRecord(totalRecord);

	   List<Map<String,Object>> dataMapList =  this.archiveService.getPublic(pagingVO);
	   pagingVO.setDataMapList(dataMapList);
	   model.addAttribute("pagingVO", pagingVO);

	   //개인자료실 사용량
	   int personalSize = this.archiveService.getPersonalUsage(empNo);

	   //부서자료실 사용량
	   int deptSize = this.archiveService.getDeptUsage(empNo);

	   //공용자료실 사용량
	   int publicSize = this.archiveService.getpublicUsage();

	   Map<String,Integer> mapAchive = new HashMap<String, Integer>();
	   mapAchive.put("personalSize", personalSize);
	   mapAchive.put("deptSize", deptSize);
	   mapAchive.put("publicSize", publicSize);

	 //이미지 개수 및 총 용량 가져오기
	   Map<String,Object> param = new HashMap<>();
	   param.put("empNo", empNo);
	   param.put("parameter","image");

	   //개인자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> personalImage = this.archiveService.personalImage(param);
	   int personalCount = Integer.parseInt(String.valueOf(personalImage.get("COUNT")));
	   int personalImageUsage = Integer.parseInt(String.valueOf(personalImage.get("PERSONALIMAGE")));

	   //부서자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> deptImage = this.archiveService.deptImage(empNo);
	   int deptImageCount = Integer.parseInt(String.valueOf(deptImage.get("COUNT")));
	   int deptImageUsage = Integer.parseInt(String.valueOf(deptImage.get("DEPTIMAGE")));

	   //공용자료실의 이미지 개수 및 총 용량 가져오기
	   Map<String,Object> publicImage = this.archiveService.publicImage();
	   int publicImageCount = Integer.parseInt(String.valueOf(publicImage.get("COUNT")));
	   int publicImageUsage = Integer.parseInt(String.valueOf(publicImage.get("PUBLICIMAGE")));

	   int ImageCount =personalCount + deptImageCount + publicImageCount;
	   int ImageUsage = personalImageUsage + deptImageUsage+ publicImageUsage;

	   mapAchive.put("ImageCount",ImageCount);
	   mapAchive.put("ImageUsage",ImageUsage);

	   //문서개수 및 용량
	   Map<String,Object> personalDoc = this.archiveService.personalDoc(empNo);
	   int personalDocCount = Integer.parseInt(String.valueOf(personalDoc.get("COUNT")));
	   int personalDocUsage = Integer.parseInt(String.valueOf(personalDoc.get("PERSONALDOC")));

	   Map<String,Object> deptDoc = this.archiveService.deptDoc(empNo);
	   int deptDocCount = Integer.parseInt(String.valueOf(deptDoc.get("COUNT")));
	   int deptDocUsage = Integer.parseInt(String.valueOf(deptDoc.get("DEPTDOC")));

	   Map<String,Object> publicDoc = this.archiveService.publicDoc();
	   int publicDocCount = Integer.parseInt(String.valueOf(publicDoc.get("COUNT")));
	   int publicDocUsage = Integer.parseInt(String.valueOf(publicDoc.get("PUBLICDOC")));

	   int docCount = personalDocCount + deptDocCount + publicDocCount;
	   int docUsage = personalDocUsage + deptDocUsage + publicDocUsage;

	   mapAchive.put("docCount",docCount);
	   mapAchive.put("docUsage",docUsage);

	   //미디어 개수 및 용량
	   Map<String,Object> personalMedia = this.archiveService.personalMedia(empNo);
	   int personalMediaCount = Integer.parseInt(String.valueOf(personalMedia.get("COUNT")));
	   int personalMideaUsage = Integer.parseInt(String.valueOf(personalMedia.get("PERSONALMEDIA")));

	   Map<String,Object> deptMedia = this.archiveService.deptMedia(empNo);
	   int deptMediaCount = Integer.parseInt(String.valueOf(deptMedia.get("COUNT")));
	   int deptMideaUsage = Integer.parseInt(String.valueOf(deptMedia.get("DEPTMEDIA")));

	   Map<String,Object> publicMedia = this.archiveService.publictMedia();
	   int publicMediaCount = Integer.parseInt(String.valueOf(publicMedia.get("COUNT")));
	   int publicMideaUsage = Integer.parseInt(String.valueOf(publicMedia.get("PUBLICMEDIA")));

	   int mediaCount = personalMediaCount + deptMediaCount + publicMediaCount;
	   int mediaUsage = personalMideaUsage + deptMideaUsage + publicMideaUsage;

	   mapAchive.put("mediaCount", mediaCount);
	   mapAchive.put("mediaUsage", mediaUsage);
	   model.addAttribute("mapAchive", mapAchive);

	   return "archive/public";
   }



/** 요청 URI : /localhost/archive/create
 * 자료(파일)를 insert하는 메서드
 * @param archiveVO
 * @return
 */
@PostMapping("/create")
   public String create(@ModelAttribute ArchiveVO archiveVO) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    CustomUser principal = (CustomUser)authentication.getPrincipal();
	    EmpVO empVO = principal.getEmpVO();
	    String empNo = empVO.getEmpNo();
	    archiveVO.setEmpNo(empNo);


	   int result = this.archiveService.create(archiveVO);

	   if(result>0) {
		   if(archiveVO.getArcGroupNm().equals("ARC0001")) {  //개인자료실
			   return "redirect:/archive/personal";
		   }

		   if(archiveVO.getArcGroupNm().equals("ARC0002")) { //부서자료실
			   return "redirect:/archive/dept";
		   }

		   if(archiveVO.getArcGroupNm().equals("ARC0003")) { //공용자료실
			   return "redirect:/archive/public";
		   }
	   }
	   return "redirect:/archive/bookmark";
   }



	/** 요청 URI : /localhost/archive/deleteFile
	 * 자료실에 업로드된 자료를 delete(삭제)하는 메서드
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/deleteFile", produces = "application/json")
	public int deleteFile(@RequestBody Map<String,Object> map) {
		int result = this.archiveService.deleteFile(map);
		return result;
	}


	/** 요청 URI : /localhost/archive/createBookmark
	 * 자료를 즐겨찾기(bookmark)에 추가하는 메서드
	 * @param bookmarkVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/createBookmark")
	public int createBookmark(@RequestBody BookmarkVO bookmarkVO) {
			int res = this.archiveService.createBookmark(bookmarkVO);
			return res;

	}

	/** 요청 URI : /localhost/archive/deleteBookmark
	 * 즐겨찾기 된 자료(파일)를 즐겨찾기 삭제하는 메서드
	 * @param bookmarkVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deleteBookmark")
	public int deleteBookmark(@RequestBody BookmarkVO bookmarkVO) {
			int res = this.archiveService.deleteBookmark(bookmarkVO);
			return res;
	}

}
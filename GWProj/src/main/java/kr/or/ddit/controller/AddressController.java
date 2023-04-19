package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
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

import kr.or.ddit.service.AddressService;
import kr.or.ddit.service.WholBService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.BookmarkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/address")
public class AddressController {
	@Autowired
	AddressService addressService;

	/*
	 1) new ArticlePage<대상VO> 처리
	 2) total : 전체 행 수 구하기
	 3) currentPage : 현재 페이지 처리(골뱅이RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage)
	 4) size : 한 화면에 보여질 행의 수
	 5) content : select 결과 list
	 ...jsp에서는.....
	 6) 페이징 영역 붙임&주소 수정
	 7) 매퍼xml : 페이징 구문으로 대체
	 8) currentPage, size, keyword를 map에 담아 select 조건으로 보내줌
	 */
	
	//주소록 목록 조회
	@GetMapping("/list")
	public String list(@ModelAttribute AddrVO addrVO, Model model,
			@RequestParam(value="searchType", required = false) String searchType,
			@RequestParam(value="keyword", required = false) String keyword,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage
			) {
		model.addAttribute("pageMain","Address");
		model.addAttribute("pageDetail","list");
		model.addAttribute("pageName","전체 주소록");


		log.info("searchType : " + searchType);
		log.info("keyword : " + keyword);
		int size = 10;
		log.info("currentPage : " + currentPage);

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		addrVO.setEmpNo(username);
		log.info("empno : " + addrVO.getEmpNo());
		
		//map{"keyword":"개똥이","currentPage":1,"size":10}
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
	    map.put("size", size+"");
	    map.put("currentPage", currentPage+"");
	    map.put("searchType", searchType);
	    map.put("keyword", keyword);
	    
	    

	    //전체 행의 수 구하기
		int total = addressService.getTotal(map);
		
		log.info("total : " + total);

		//주소록 전체 목록 구하기
		List<AddrVO> addrList = addressService.getAllAddrList(map);

		log.info("list목록 : " + addrList);

		model.addAttribute("data", new ArticlePage<AddrVO>(total, currentPage, size, addrList));
		model.addAttribute("searchType", searchType);

		return "address/list";
	}

	@GetMapping("/create")
	public String create() {
		return "address/create";
	}

	//주소록 추가
	@PostMapping("/createPost")
	public String createPost( @ModelAttribute @Valid AddrVO addrVO, HttpServletRequest req, Model model
				,@RequestParam(required=false, defaultValue="new") String mode) {
		log.info("--------------------------------------------------");
		// 스프링 시큐리티를 통한 로그인 시, UserDetail에 할당된 회원정보를 가져올때 사용한다. Start
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();
		String password = userDetails.getPassword();
		// End
		log.info("--------------------------------------------------");
		log.info("username : " + username);
		log.info("password : " + password);
		log.info("addrVO : " + addrVO);
		addrVO.setEmpNo(username);

		log.info("mode : " + mode);

		int result = addressService.createPost(addrVO);

		if(mode.equals("update")) {//update라면
			return "redirect:/address/detail?addrNo="+addrVO.getAddrNo();
		}else {//insert라면
			return "redirect:/address/list";
		}
	}
	
	//주소록 수정
	@PostMapping("/updatePost")
	public String updatePost(@ModelAttribute AddrVO addrVO) {
		log.info("addrVO 요요 : " + addrVO);
		
		int updatePostVO = addressService.updatePost(addrVO);
		log.info("updatePostVO : " + updatePostVO);
		
		return "redirect:/address/list";
		
	}
	
	@GetMapping("/detail")
	public String detail(@ModelAttribute AddrVO addrVO, Model model) {
		model.addAttribute("pageMain","Address");
		model.addAttribute("pageDetail","detail");
		model.addAttribute("pageName","주소록 상세");


		log.info("addrVO detail: " + addrVO);
		AddrVO data = addressService.detail(addrVO);
		log.info("data : " + data);
		model.addAttribute("data", data);
		return "address/detail";
	}

	//주소록 상세보기
	@PostMapping("/deletePost")
	public String deletePost(@ModelAttribute AddrVO addrVO) {
		int delete = addressService.deletePost(addrVO);

		return "redirect:/address/list";
	}

	//주소록 삭제(다중)
	//json으로 리턴
	@ResponseBody
	@PostMapping("/deleteMultiPost")
	public int deleteMultiPost(@RequestBody AddrVO addrVO) {
		log.info("addrVO : " + addrVO);

		int deleteMulti = addressService.deleteMulti(addrVO);
		log.info("deleteMulti ==> {}", deleteMulti);

		return deleteMulti;

	}

	//즐겨찾기 주소록에 추가
	@ResponseBody
	@PostMapping("/sendBookMark")
	public int sendBookMark(@RequestBody BookmarkVO bookmarkVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		bookmarkVO.setEmpNo(username);
		log.info("bookmarkVO : " + bookmarkVO);

		int sendBookMark = addressService.sendBookMark(bookmarkVO);

		log.info("sendBookMark : " + sendBookMark);

		return sendBookMark;

	}

	@GetMapping("/bookMarkList")
	public String bookMarkList(@ModelAttribute BookmarkVO bookmarkVO, Model model,
			@ModelAttribute AddrVO addrVO,
			@RequestParam(value="searchType", required = false) String searchType,
			@RequestParam(value="keyword", required = false) String keyword,
			@RequestParam(name="currentPage",required=false,defaultValue="1") int currentPage) {
		model.addAttribute("pageMain","Address");
		model.addAttribute("pageDetail","bookMark");
		model.addAttribute("pageName","즐겨찾는 주소록");


		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		log.info("searchType : " + searchType);
		log.info("keyword : " + keyword);
		log.info("currentPage : " + currentPage);
		log.info("addrVO : " + addrVO);

		addrVO.setEmpNo(username);

		List<AddrVO> bookmarkList =  addressService.bookMarkList(addrVO);

		int size = 10;

		//map{"keyword":"개똥이","currentPage":1,"size":10}
		Map<String, String> map = new HashMap<String, String>();
		map.put("username",username);
	    map.put("size", size+"");
	    map.put("currentPage", currentPage+"");
	    map.put("searchType", searchType);
	    map.put("keyword", keyword);

	    //전체 행의 수 구하기
		int total = addressService.getTotal(map);

		//주소록 전체 목록 구하기
		List<AddrVO> addrList = addressService.getAllAddrList(map);

		log.info("list목록 : " + addrList);

		model.addAttribute("data", new ArticlePage<AddrVO>(total, currentPage, size, bookmarkList));
		model.addAttribute("searchType", searchType);
		model.addAttribute("bookmarkList",bookmarkList);

		return "address/bookMarkList";
	}

	//즐겨찾기 주소록 삭제(다중)
	@ResponseBody
	@PostMapping("/bookmarkDel")
	public int bookmarkDel(@RequestBody BookmarkVO bookmarkVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		bookmarkVO.setEmpNo(username);

		log.info("bookmarkDel 목록 : {} ", bookmarkVO);

		int bookmarkDel = addressService.bookmarkDel(bookmarkVO);

		log.info("bookmarkDel 결과 : {}", bookmarkDel);

		return bookmarkDel;
	}
		
	@GetMapping("/addrMail")
	public String addrMail(Model model) {
		model.addAttribute("stat", "addrMail");
		return "mail/write.empty";
	}


}



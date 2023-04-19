package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.security.CustomUser;
import kr.or.ddit.service.FileService;
import kr.or.ddit.service.ProjService;
import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.ProjVO;
import kr.or.ddit.vo.PrtpntVO;
import kr.or.ddit.vo.TaskCountVO;
import kr.or.ddit.vo.TaskVO;
import kr.or.ddit.vo.TodoVO;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/projects")
@Controller
public class TaskController {
	@Autowired
	ProjService projService;
	@Autowired
	FileService fileService;

	//태스크 등록
	@PostMapping("/taskCreate")
	public String taskCreate(@ModelAttribute TaskVO taskVO) {
		log.info("taskVO : " + taskVO);
		String projNo = taskVO.getProjNo();

		int res = this.projService.taskCreate(taskVO);

		if(res > 0) {
			return "redirect:/projects/projDetail?projNo=" + projNo;
		}else {
			return "redirect:/projects/projDetail?projNo=" + projNo;
		}
	}

	//진행중인 태스크의 개수
	@ResponseBody
	@PostMapping("/ingTask")
	public int ingTask(@RequestBody ProjVO projVO) {
		log.info("projVO : " + projVO);
		int ingTask = this.projService.ingTask(projVO);
		log.info("ingTask : " + ingTask);

		return ingTask;
	}

	//태스크 상세보기
	@ResponseBody
	@PostMapping("/taskDetail")
	public TaskVO taskDetail(@RequestBody TaskVO taskVO) {
		log.info("taskVO : " + taskVO);

		TaskVO taskDetailVO = this.projService.taskDetail(taskVO);

		log.info("taskDetailVO : " + taskDetailVO);

		return taskDetailVO;
	}

	//체크리스트 체크
	@ResponseBody
	@PostMapping("/chkY")
	public int chkY(@RequestBody ChkVO chkVO) {
		log.info("chkVO : " + chkVO);

		int chkY = this.projService.chkY(chkVO);

		log.info("chkY : " + chkY);

		return chkY;
	}

	//체크리스트 체크해제
	@ResponseBody
	@PostMapping("/chkN")
	public int chkN(@RequestBody ChkVO chkVO) {
		log.info("chkVO : " + chkVO);

		int chkN = this.projService.chkN(chkVO);

		log.info("chkN : " + chkN);

		return chkN;
	}

	//체크리스트 등록
	@ResponseBody
	@PostMapping("/addChkList")
	public String addChkList(@RequestBody ChkVO chkVO) {
		log.info("chkVO : " + chkVO);

		int addChkList = this.projService.addChkList(chkVO);

		log.info("addChkList : " + addChkList);

		return chkVO.getChkNo();
	}

	//체크리스트 삭제
	@ResponseBody
	@PostMapping("/delChkList")
	public int delChkList(@RequestBody ChkVO chkVO) {
		log.info("chkVO : " + chkVO);

		int delChkList = this.projService.delChkList(chkVO);

		log.info("delChkList : " + delChkList);

		return delChkList;
	}

	//댓글 등록
	@ResponseBody
	@PostMapping("/createCmnt")
	public int createCmnt(@RequestBody CmntVO cmntVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = ((UserDetails) principal).getUsername();
		cmntVO.setEmpNo(username);
		log.info("cmntVO : " + cmntVO);

		int createCmnt = this.projService.createCmnt(cmntVO);

		log.info("createCmnt : " + createCmnt);

		return cmntVO.getCmntNo();
	}

	//댓글 삭제
	@ResponseBody
	@PostMapping("/delCmntList")
	public int delCmntList(@RequestBody CmntVO cmntVO) {
		log.info("cmntVO : " + cmntVO);

		int delCmntList = this.projService.delCmntList(cmntVO);

		log.info("delCmntList : " + delCmntList);

		return delCmntList;
	}

	//댓글 수정
	@ResponseBody
	@PostMapping("/updateCmnt")
	public int updateCmnt(@RequestBody CmntVO cmntVO) {
		log.info("cmntVO : " + cmntVO);

		int updateCmnt = this.projService.updateCmnt(cmntVO);

		log.info("updateCmnt : " + updateCmnt);

		return updateCmnt;
	}

	//태스크 이동
	@ResponseBody
	@PostMapping("/updateSsts")
	public int updateSsts(@RequestBody TaskVO taskVO) {
		log.info("taskVO : " + taskVO);

		int updateSsts = this.projService.updateSsts(taskVO);

		log.info("updateSsts : " + updateSsts);

		return updateSsts;
	}

	//태스크 설명 추가
	@ResponseBody
	@PostMapping("/createExp")
	public int createExp(@RequestBody TaskVO taskVO) {
		log.info("taskVO : " + taskVO);

		int createExp = this.projService.createExp(taskVO);

		log.info("createExp : " + createExp);

		return createExp;
	}

	//태스크 설명 추가
	@ResponseBody
	@PostMapping("/createLabel")
	public int createLabel(@RequestBody TaskVO taskVO) {
		log.info("taskVO : " + taskVO);

		int createLabel = this.projService.createLabel(taskVO);

		log.info("createLabel : " + createLabel);

		return createLabel;
	}

	//파일 업로드
	@ResponseBody
	@PostMapping("/uploadFile")
	public String uploadFile(TaskVO taskVO) {
		log.info("파일업로드 컨트롤러에 왔다!!!");
		log.info("파일taskVO : " + taskVO);

		//FILES 테이블 처리
		this.fileService.taskFilecreate(taskVO);
		log.info("업로드 후 taskVO : " + taskVO);

		//TASK 테이블 처리
		this.projService.taskUpdate(taskVO);

		return "";
	}

	//파일 삭제
	@ResponseBody
	@PostMapping("/deleteFile")
	public int deleteFile(@RequestBody FilesVO filesVO) {
		log.info("filesVO : " + filesVO);

		int deleteFile = this.projService.deleteFile(filesVO);

		log.info("deleteFile : " + deleteFile);

		return deleteFile;
	}
}

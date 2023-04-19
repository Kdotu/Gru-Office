package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.OrgService;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/org")
@Controller
public class OrgController {
	@Autowired
	OrgService orgService;
	
	@ResponseBody
	@PostMapping("/orgAdminEmp")
	public List<EmpVO> orgAdminEmp(){
//		조직도 소속부서가 없는 최상위 직급 (대표, 이사) 
		
		List<EmpVO> empVOList = this.orgService.orgAdminEmp();
		
		log.info("empVOList : " + empVOList);
		
		return empVOList;
	}
	
	@ResponseBody
	@PostMapping("/orgEmp")
	public List<EmpVO> orgEmp(@RequestBody Map<String,String> deptMap){
		log.info("deptMap : " + deptMap);
		
		EmpVO empVO = new EmpVO();
		
		empVO.setDeptNo(deptMap.get("deptNo"));
		
		List<EmpVO> empList = this.orgService.orgEmp(empVO); 
		
		log.info("사원목록 : empList : " + empList);
		return empList; 
	}
		
	@ResponseBody
	@PostMapping("/empModal")
	public EmpVO empModal(@RequestBody Map<String,String> empMap){
		log.info("empMap : " + empMap);
		
		EmpVO empVO = new EmpVO();
		
		empVO.setEmpNo(empMap.get("empNo"));
		
		EmpVO empvo = this.orgService.empModal(empVO); 
		
		return empvo; 
	}
	
	
	@ResponseBody
	@PostMapping("/searchResult")
	public List<Map<String, String>> searchResult(@RequestBody Map<String,String> parammap){
		log.info("map : " + parammap.get("searchText"));
		
		//먼저 검색 결과가 있는지 확인 
//		int result = this.orgService.searchCount(parammap); 
		
		List<Map<String, String>> searchList = this.orgService.searchResult(parammap); 
		
		log.info("searchList : " + searchList);
		return searchList; 
	}
}

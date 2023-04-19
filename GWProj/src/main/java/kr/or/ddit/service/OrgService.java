package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;

public interface OrgService {

	//조직도 대표/이사 목록 가져오기 
	public List<EmpVO> orgAdminEmp();

	//조직도 해당 부서에 해당하는 팀원들 목록 가져오기 
	public List<EmpVO> orgEmp(EmpVO empVO);
	
	//조직도 모달 명함
	public EmpVO empModal(EmpVO empVO);
	
	//조직도 검색 결과 반환
	public List<Map<String, String>> searchResult(Map<String, String> parammap);

	public int searchCount(Map<String, String> parammap);
	
	
}

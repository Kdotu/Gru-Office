package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;

public interface OrgMapper {
	
	//조직도 부서(팀) 계층형쿼리 목록 
	public List<EmpVO> orgAdminEmp();

	//조직도 부서번호에 해당하는 팀원들 목록 불러오기 
	public List<EmpVO> orgEmp(EmpVO empVO);
	
	//조직도 명함
	public EmpVO empModal(EmpVO empVO);

	public List<Map<String, String>> searchResult(Map<String, String> parammap);

	public int searchCount(Map<String, String> parammap);


	
	
}

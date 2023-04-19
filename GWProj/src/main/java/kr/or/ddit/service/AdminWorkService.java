package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AuthrtVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.WorkVO;

public interface AdminWorkService {
	
	//신규사원 생성 시 사원번호 자동생성 
	public EmpVO getEmpNo();
	
	//신규사원 insert(serviceImpl에서 테이블 insert 2개로 나눔)
	public int insertEmp(EmpVO empVO);
	
	//총 사원 List 뽑아오기 
	public List<EmpVO> getEmpList();
	
	//재직 퇴사에 선택에 따른 사원리스트 
	public List<EmpVO> empSearch(EmpVO empVO);
	
	//직원 상세 및 수정 페이지 
	public EmpVO updateEmp(EmpVO empVO);
	
	// 직원 정보 수정 
	public int updateEmpPost(EmpVO empVO);

	public int updateAuthPost(List<AuthrtVO> empAuthVOList); 
	
	//퇴사처리 
	public int empExit(Map<String, String> map); 
	
	//퇴사 복구 처리 
	public int empRejoin(Map<String, String> map);
	
	//전사원 근태현황 리스트 
	public List<WorkVO> getDeptWork(Map<String, String> map);
	
	// 전사원 근태 
	public Map<String, Object> TeamMonth(Map<String, String> map);

	public Map<String, String> getDeptPerson();

	public Map<String, String> getDeptPerson2(Map<String, String> map);

	public Map<String, Object> getMonthCNT(Map<String, String> map);

	public Map<String, Object> getDeptInfo(Map<String, String> map);

	public Map<String, String> getAllWorkCount(Map<String, String> map);

	public List<Map<String, String>> getDeptWorkCount(Map<String, String> map); 
}

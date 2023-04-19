package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AuthrtVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.WorkVO;

public interface AdminWorkMapper {

	public EmpVO getEmpNo();
	
	//직원등록
	public int insertEmp(EmpVO empVO);
	
	//권한등록
	public int insertAuthrt(AuthrtVO empAuthVO);

	//사원 List 뽑아오기
	public List<EmpVO> getEmpList();
	
	//재직/퇴사 선택에 따른 사원 리스트 
	public List<EmpVO> empSearch(EmpVO empVO);
	
	// 직원 상세 및 수정 페이지 
	public EmpVO updateEmp(EmpVO empVO);

	// 직원 정보 수정 
	public int updateEmpPost(EmpVO empVO);
	
	//권한 삭제 
	public int deleteAllAuth(String empNo); 
	
	//퇴사처리 
	public int empExit(Map<String, String> map); 
	
	//퇴사 복구 처리 
	public int empRejoin(Map<String, String> map);

	public List<WorkVO> getDeptStatis(Map<String, String> map);

	public List<WorkVO> getDept2(Map<String, String> map);

	public Map<String, Object> TeamMonthCNT(Map<String, String> map);

	public Map<String, Object> TeamMonth(Map<String, String> map);

	public Map<String, String> getDeptPerson();

	public Map<String, String> getDeptPerson2(Map<String, String> map);

	public Map<String, Object> getMonthCNT(Map<String, String> map);

	public Map<String, Object> getDeptInfo(Map<String, String> map);

	public int searchCount(Map<String, String> map);

	public Map<String, Object> getDeptInfo2(Map<String, String> map);

	public Map<String, String> getAllWorkCount(Map<String, String> map);

	public List<Map<String, String>> getDeptWorkCount(Map<String, String> map); 
}

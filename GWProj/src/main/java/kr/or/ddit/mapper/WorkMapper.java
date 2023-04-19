package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.Work2VO;
import kr.or.ddit.vo.Work3VO;
import kr.or.ddit.vo.WorkVO;

public interface WorkMapper {
	
	//출근 버튼 눌렀을 때 근태관리 테이블에 insert
	public int insertgw(EmpVO empVO);
	
	//퇴근 버튼을 눌렀을 때 근태관리 테이블 update
	public int insertgh(EmpVO empVO);
	
	//근태관리 상태 변경 
	public int updateSsts(WorkVO workVO);
	
	//해당사원의 오늘 출근/퇴근/근무상태 정보 가져오기
	public EmpVO selectTime(EmpVO empVO);
	
	//출근버튼 중복 비활성화용
	public WorkVO countWork(WorkVO workVO);
	
	//로그인한 사원의 부서정보 가져오기 (본부-팀)
	public EmpVO getTeam(EmpVO empVO);
		
	//달에 따른 근태정보 
	public List<Work2VO> MonthWork(Map<String, String> map);
	
	//달에 따른 한달 누적 근무시간 
	public WorkVO getMonthWT(Map<String, String> map);
	
	//월별 근무상태 가져오기 
	public Map<String, String> getMonthCNT(Map<String, String> map);
	
	//해당 부서 총 인원수 
	public Map<String, String> getDeptPerson(Map<String, String> map);

	//부서 월별 근태통계 
	public Map<String, Object> TeamMonthCNT(Map<String, String> map);
	
	//부서 월별 근태 리스트 (월 정보가 파라미터로 있을 때) 
	public List<WorkVO> getDept2(Map<String, String> map);
	
	//부서 월별 근태 리스트 (처음 페이지 요청 시) 
	public List<WorkVO> getDeptStatis(Map<String, String> map);

	public Map<String, Object> TeamMonth(Map<String, String> map);
	
	//해당 달의 주별 누적근무시간
	public List<Work2VO> getWeekSum(Map<String, String> map);
	
	//이번주에 해당하는 누적 근무시간 가져오기
	public Work2VO thisWeekSum(Map<String, String> map);
	
	//해당사원의 연차 승인 목록
	public List<Map<String, Object>> getHoliInfo(EmpVO empVO);
	
	//부서 근태현황페이지 전체 목록 
	public List<Work3VO> getDeptWeek(Map<String, String> map); 
	
	//부서 근태현황페이지 검색결과 리스트 
	public List<Work3VO> deptWorkSearch(Map<String, String> map);

	public int pptGoWork(EmpVO empVO);

	public int pptGoHome(EmpVO empVO);
	
}

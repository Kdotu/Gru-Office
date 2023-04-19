package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.Work2VO;
import kr.or.ddit.vo.Work3VO;
import kr.or.ddit.vo.WorkVO;

public interface WorkService {

	//출근시간 insert
	public int insertgw(EmpVO empVO);

	//퇴근시간 등 update
	public int insertgh(EmpVO empVO);
	
	//근무상태 update
	public int updateSsts(WorkVO workVO);
	
	//오늘날짜의 출근/퇴근/근무상태 정보 select 
	public EmpVO selectTime(EmpVO empVO);
	
	//출근버튼 중복클릭 비활성화용
	public WorkVO countWork(WorkVO WorkVO);
	
	//로그인한 사원의 부서 정보 (본부-팀)
	public EmpVO getTeam(EmpVO empVO);
	
	//workList페이지에 로그인한 사원의 현재 달 근태정보를 뿌려주기 위함 
	public List<Work2VO> getEmpWork(Map<String, String> map);
	
	//현재 달, 로그인한 사원의 한달 누적 근무시간 
	public WorkVO getMonthWT(Map<String, String> map);
	
	//월기준 근무상태 가져오기 
	public Map<String, String> getMonthCNT(Map<String, String> map); 
	
	//해당 부서 총 인원수 
	public Map<String, String> getDeptPerson(Map<String, String> map);
	
	//부서 월별 근태 통계 (workStatis) 
	public Map<String, Object> TeamMonthCNT(Map<String, String> map);
	
	//부서 월별 근태 리스트 
	public List<WorkVO> getDeptWork(Map<String, String> map);

	public Map<String, Object> TeamMonth(Map<String, String> map);
	
	//해당 달의 주별 누적 근무시간 
	public List<Work2VO> getWeekSum(Map<String, String> map);
	
	//이번주에 해당하는 누적 근무 시간 가져오기 
	public Work2VO thisWeekSum(Map<String, String> map);
	
	//해당 사원의 연차 신청 승인 목록 
	public List<Map<String, Object>> getHoliInfo(EmpVO empVO);
	
	//부서 근태현황페이지 전체 목록 
	public List<Work3VO> getDeptWeek(Map<String, String> map); 
	
	//부서 근태현황페이지 검색결과 리스트 
	public List<Work3VO> deptWorkSearch(Map<String, String> map);
	
	//시연용 출근버튼
	public int pptGoWork(EmpVO empVO);
	
	//시연용 퇴근버튼
	public int pptGoHome(EmpVO empVO);
}

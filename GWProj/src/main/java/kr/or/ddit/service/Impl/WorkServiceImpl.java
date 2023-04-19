package kr.or.ddit.service.Impl;


import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.WorkMapper;
import kr.or.ddit.service.WorkService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.Work2VO;
import kr.or.ddit.vo.Work3VO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WorkServiceImpl implements WorkService {

	@Inject
	private WorkMapper workMapper;

	@Override
	public int insertgw(EmpVO empVO) {
		
		return workMapper.insertgw(empVO);
	}

	@Override
	public int insertgh(EmpVO empVO) {
		return workMapper.insertgh(empVO);
	}

	@Override
	public int updateSsts(WorkVO workVO) {
		return workMapper.updateSsts(workVO);
	}

	@Override
	public EmpVO selectTime(EmpVO empVO) {
		return workMapper.selectTime(empVO);
	}

	@Override
	public WorkVO countWork(WorkVO workVO) {
		return workMapper.countWork(workVO);
	}

	@Override
	public EmpVO getTeam(EmpVO empVO) {
		return workMapper.getTeam(empVO);
	}

	//map : {dt=20230321, month=202303, empNo=202301}
	@Override
	public List<Work2VO> getEmpWork(Map<String, String> map) {
		return workMapper.MonthWork(map); 
	}

	@Override
	public WorkVO getMonthWT(Map<String, String> map) {
		return workMapper.getMonthWT(map); 
	}

	@Override
	public Map<String, String> getMonthCNT(Map<String, String> map) {
		return workMapper.getMonthCNT(map); 
	}

	@Override
	public Map<String, String> getDeptPerson(Map<String, String> map) {
		return workMapper.getDeptPerson(map);
	}

	@Override
	public Map<String, Object> TeamMonthCNT(Map<String, String> map) {
		return workMapper.TeamMonthCNT(map);
	}

	@Override
	public List<WorkVO> getDeptWork(Map<String, String> map) {
		
		if(map.get("month") != null) {
			//month 
			log.info("널이 아닐때"); 
			return workMapper.getDept2(map); 
		}else {
			//처음 페이지 요청시 수행되는 쿼리 
			log.info("널일때"); 
			return workMapper.getDeptStatis(map);
		}
	}

	@Override
	public Map<String, Object> TeamMonth(Map<String, String> map) {
		
		//널이 아닐 때 
		if(map.get("month") != null) {
			//month 
			log.info("널이 아닐때"); 
			return workMapper.TeamMonthCNT(map); 
			
		}else {
			//처음 페이지 요청시 수행되는 쿼리 
			log.info("널일때"); 
			return workMapper.TeamMonth(map);
		}
	}

	@Override
	public List<Work2VO> getWeekSum(Map<String, String> map) {
		return workMapper.getWeekSum(map); 
	}

	@Override
	public Work2VO thisWeekSum(Map<String, String> map) {
		return workMapper.thisWeekSum(map); 
	}

	@Override
	public List<Map<String, Object>> getHoliInfo(EmpVO empVO) {
		return workMapper.getHoliInfo(empVO);
	}

	@Override
	public List<Work3VO> getDeptWeek(Map<String, String> map) {
		return workMapper.getDeptWeek(map); 
	}

	@Override
	public List<Work3VO> deptWorkSearch(Map<String, String> map) {
		return workMapper.deptWorkSearch(map);
	}

	@Override
	public int pptGoWork(EmpVO empVO) {
		return workMapper.pptGoWork(empVO);
	}

	@Override
	public int pptGoHome(EmpVO empVO) {
		return workMapper.pptGoHome(empVO);
	}
	

	
	

}

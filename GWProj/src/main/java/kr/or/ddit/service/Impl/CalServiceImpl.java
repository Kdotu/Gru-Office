package kr.or.ddit.service.Impl;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.CalMapper;
import kr.or.ddit.service.CalService;
import kr.or.ddit.vo.CalVO;
import kr.or.ddit.vo.EmpVO;

@Service
public class CalServiceImpl implements CalService {

	@Inject
	private CalMapper calMapper;
	
	@Override
	public List<CalVO> getCal(CalVO calVO) {
		return calMapper.getCal(calVO);
	}

	@Override
	public int createCalender(CalVO calVO) {
		return calMapper.createCalender(calVO);
	}

	@Override
	public int updateCalender(CalVO calVO) {
		return calMapper.updateCalender(calVO);
	}

	@Override
	public int deleteCalender(CalVO calVO) {
		return calMapper.deleteCalender(calVO);
	}

	@Override
	public int updateCalenderDay(CalVO calVO) {
		return calMapper.updateCalenderDay(calVO);
	}

	@Override
	public EmpVO getEmp() {
		return calMapper.getEmp();
	}

	@Override
	public int todayCalCount(EmpVO empVO) {
		return calMapper.todayCalCount(empVO);
	}

	@Override
	public List<CalVO> getCalAnother(CalVO calVO) {
		return calMapper.getCalAnother(calVO);
	}


}

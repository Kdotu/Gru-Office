package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CalVO;
import kr.or.ddit.vo.EmpVO;

public interface CalService {

	/**
	 * 캘린더(일정)테이블의 본인 전체 정보를 가져옴
	 * @param calVO
	 * @return List 로 캘린더 본인 전체 정보를 리턴
	 */
	public List<CalVO> getCal(CalVO calVO);

	/**
	 * 일정 생성 성보를 보냄
	 * @param calVO
	 * @return 생성된 일정 수, 실패시 0
	 */
	public int createCalender(CalVO calVO);

	/**
	 * 일정 업데이트 정보를 보냄
	 * @param calVO
	 * @return 수정된 일정 수, 실패시 0
	 */
	public int updateCalender(CalVO calVO);

	/**
	 * 일정 삭제 정보를 보냄
	 * @param calVO
	 * @return 생성된 일정 수
	 */
	public int deleteCalender(CalVO calVO);

	/**
	 * 일정의 날짜 수정 정보를 보냄
	 * @param calVO
	 * @return 수정된 일정 수, 실패시 0
	 */
	public int updateCalenderDay(CalVO calVO);

	/**
	 * 관리자 계정 정보를 가져옴
	 * @return EmpVO
	 */
	public EmpVO getEmp();

	/**
	 * 사원 정보를 보냄
	 * @param empVO
	 * @return int 로 오늘자 전체 일정 수를 리턴
	 */
	public int todayCalCount(EmpVO empVO);

	/**
	 * 일정 생성 성보를 보냄
	 * @param calVO
	 * @return List<CalVO> 에 사원의 일정정보를 불러옴
	 */
	public List<CalVO> getCalAnother(CalVO calVO);


}

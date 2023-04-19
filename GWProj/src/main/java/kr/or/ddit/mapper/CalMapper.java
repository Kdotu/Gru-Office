package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.CalVO;
import kr.or.ddit.vo.EmpVO;

public interface CalMapper {
	
	/**
	 * 캘린더(일정)테이블의 본인 전체 정보를 가져옴
	 * @param calVO
	 * @return List 로 캘린더 본인 전체 정보를 리턴
	 */
	public List<CalVO> getCal(CalVO calVO);

	/**
	 * 캘린더 생성을 위한 정보를 보냄
	 * @param calVO
	 * @return int 생성된 컬럼 수 리턴
	 */
	public int createCalender(CalVO calVO);

	/**
	 * 캘린더 수정을 위한 정보를 보냄
	 * @param calVO
	 * @return int 수정된 컬럼 수 리턴
	 */
	public int updateCalender(CalVO calVO);

	/**
	 * 캘린더 삭제를 위한 정보를 보냄
	 * @param calVO
	 * @return int 삭제된 컬럼 수 리턴
	 */
	public int deleteCalender(CalVO calVO);

	/**
	 * 캘린더 날짜 수정을 위한 정보를 보냄
	 * @param calVO
	 * @return int 날짜 수정된 컬럼 수 리턴
	 */
	public int updateCalenderDay(CalVO calVO);

	/**
	 * 관리자 계정 정보 리턴
	 * @return EmpVO
	 */
	public EmpVO getEmp();

	/**
	 * 오늘자 예정된 일정 수를 출력함
	 * @param empVO
	 * @return int 오늘자 일정 컬럼 수 리턴
	 */
	public int todayCalCount(EmpVO empVO);

	/**
	 * 다른 사람의 일정 정보를 불러옴
	 * @param calVO
	 * @return List<CalVO> 로 일정정보 리턴
	 */ 
	public List<CalVO> getCalAnother(CalVO calVO);
}

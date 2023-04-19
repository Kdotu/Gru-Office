package kr.or.ddit.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.DailyReportVO;

public interface DailyReportMapper {


	/**
	 * 사원번호를 입력받아 일일업무보고의 전체 목록을 불러오는 메서드
	 * @param reportMap
	 * @return
	 */
	public List<DailyReportVO> getAllList(Map<String, String> reportMap);

	/**
	 * 사원번호를 입력받아 해당 사원의 부서 일일업무보고의 목록을 불러오는 메서드
	 * @param reportMap
	 * @return
	 */
	public List<DailyReportVO> getDeptList(Map<String, String> reportMap);

	/**
	 * 관리자 사원번호를 입력받아 해당 사원의 전체 부서별 일일업무보고의 목록을 불러오는 메서드
	 * @param map
	 * @return
	 */
	public List<DailyReportVO> getDeptListAdmin(Map<String, String> map);

	/**
	 * 일일업무보고 작성 내용을 DB에 저장하는 메서드
	 * @param dailyRVO
	 * @return (성공:1 / 실패:0)
	 */
	public int createReport(DailyReportVO dailyRVO);

	/**
	 * 일일업무보고 작성 내용을 수정하는 메서드
	 * @param dailyRVO
	 * @return (성공:1 / 실패:0)
	 */
	public int modifyReport(DailyReportVO dailyRVO);

	/**
	 * 날짜 정보와 사원번호를 담은 dailyRVO를 매개변수로 하여
	 * 해당 날짜에 작성한 보고의 내용을 가져오는 메서드
	 * @param 검색하고 싶은 날짜 정보를 가진 dateInfo, 사원번호를 담은 dateMap
	 * @return
	 */
	public DailyReportVO dateList(HashMap<String, String> dateMap);

	/**
	 * 사원번호를 입력받아 금일 일일업무 작성 보고 여부를 확인하는 메서드
	 * @param dailyRVO
	 * @return (작성완료 : 1 / 미작성 : 0)
	 */
	public int checkReport(DailyReportVO dailyRVO);

	/** 업무보고 변수를 입력받아 업무보고 상세 내용을 불러오는 메서드
	 * @param rptpNo
	 * @return
	 */
	public DailyReportVO getReportDetail(DailyReportVO dailyReportVO);

	/**
	 * 사원번호를 입력받아 현재 날짜로 작성한 일일업무보고 번호를 가져오는 메서드
	 * @param dailyRVO
	 * @return 일일업무보고 번호
	 */
	public DailyReportVO getCreateReportNo(DailyReportVO dailyRVO);

	/**
	 * 페이징
	 * 사원번호, 날짜 정보를 입력받아 전체 행의 수를 가져오는 메서드
	 * @param map
	 * @return
	 */
	public int getEmpReportTotal(Map<String, String> map);

	/**
	 * 페이징
	 * 사원번호, 날짜 정보를 입력받아 부서별 업무보고 목록의 전체 행의 수를 가져오는 메서드
	 * @param map
	 * @return
	 */
	public int getDeptReportTotal(Map<String, String> map);



	/**
	 * 사원번호, 날짜 정보를 입력받아 부서별 업무보고 목록의 전체 행의 수를 가져오는 메서드
	 * 최상위 부서에 속한 관리자 검색용
	 * @param map
	 * @return
	 */
	public int getDeptReportTotalAdmin(Map<String, String> map);


	/**
	 * 사원번호를 입력받아 사원이 속한 부서의 부서원 수를 구하는 메서드
	 * @param empNo
	 * @return 부서원의 수
	 */
	public int getDeptMemCount(String empNo);

	/**
	 * 사원번호를 입력받아 해당 사원이 속한 부서의 부서원의 당일 일일보고 목록을 구하는 메서드
	 * @param empNo
	 * @return 일일업무보고 번호,사원번호, 사원명
	 */
	public List<DailyReportVO> getDeptMemList(String empNo);


	/**
	 * 사원번호를 입력받아 해당 사원이 속한 부서의 부서원의 당일 일일보고 수를 구하는 메서드
	 * @param empNo
	 * @return 일일업무보고 번호,사원번호, 사원명
	 */
	public int getDeptMemListCount(String empNo);


	/**
	 * 미확인 일일보고 수를 가져오는 메서드
	 * @param empNo
	 * @return
	 */
	public int nonChkReportCount(String empNo);



	/**
	 * 일일업무보고 보고확인 상태를 확인한 것으로 변경하는 메서드
	 * @param dailyRVO
	 * @return
	 */
	public int confirmReport(DailyReportVO dailyRVO);



	/**
	 * 보고확인 담당자 번호를 입력받아 금일 확인한 일일업무보고 목록수를 가져오는 메서드
	 * @param rptpCmptnPic
	 * @return
	 */
	public int todayChkReportCount(String rptpCmptnPic);


	/**
	 * 현재 일자부터 일주일 전 일자 사이 보고 현황을 가져오는 메서드
	 * (날짜별 보고자 수만 산정해옴)
	 * @param empNo
	 * @return
	 */
	public List<DailyReportVO> getWeekReport(String empNo);


	/**
	 * (부서별 메인 차트용)
	 * 해당 사원이 속한 부서의 일별, 주별, 일별 일일보고 수를 가져오는 메서드
	 * @param empNo
	 * @return
	 */
	public DailyReportVO deptReportChart(String empNo);


	/**
	 * (부서별 현황 차트용)
	 * 해당 부서의 일별 일일업무보고 수를 가져오는 메서드
	 * @param empNo
	 * @return
	 */
	public List<Map<String, String>> deptReportDepDayChart(String empNo);

	/**
	 * (부서별 현황 차트용)
	 * 해당 부서의 일별 일일업무보고 수를 가져오는 메서드
	 * @param empNo
	 * @return
	 */
	public List<Map<String, String>> deptReportDepWeekChart(String empNo);

	/**
	 * (부서별 현황 차트용)
	 * 해당 부서의 월별 일일업무보고 수를 가져오는 메서드
	 * @param empNo
	 * @return
	 */
	public List<Map<String, String>> deptReportDepMonthChart(String empNo);

}

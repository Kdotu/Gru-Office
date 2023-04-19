package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.AlarmListVO;
import kr.or.ddit.vo.AlarmRecvVO;

public interface AlarmService {

	/**
	 * @param username
	 * @return 안읽은 알림의 개수
	 */
	public int alarmCount(String username);

	/**
	 * @param username
	 * @return 알림목록 리스트
	 */
	public List<AlarmListVO> alarmList(String username);

	/**
	 * @param alarmListVO
	 * @return 삭제된 알림의 수
	 */
	public int deleteAlarm(AlarmListVO alarmListVO);

	/**
	 * @param alarmListVO
	 * @return 전체삭제된 알림의 수
	 */
	public int deleteAllAlarm(AlarmListVO alarmListVO);

	/**
	 * @param alarmRecvVO
	 * @return 확인처리된 알림의 개수
	 */
	public int checkAlarm(AlarmRecvVO alarmRecvVO);

	/**
	 * @param username
	 * @return 헤더에 띄울 안읽은 알림 목록
	 */
	public List<AlarmListVO> mainHeader(String username);

}

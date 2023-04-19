package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AlarmRecvVO;
import kr.or.ddit.vo.AtrzLineInfoVO;
import kr.or.ddit.vo.AtrzRfrncVO;
import kr.or.ddit.vo.AtrzVO;
import kr.or.ddit.vo.EdocVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface EdocMapper {


	/** 사원번호를 불러와 해당사원의 잔여 연차를 불러오는 메서드
	 * @param empVO
	 * @return
	 */
	public int getCtrHoli(EmpVO empVO);


	/** 결재할 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재할 문서의 총 개수
	 */
	public int getApproveTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/**  결재할 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재할 문서 리스트
	 */
	public List<Map<String, Object>> getApprove(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 전자결재문서번호를 가져와 해당 문서의 결재자 및 결재 상황을 출력하는 메서드
	 * @param edocNo
	 * @return
	 */
	public List<Map<String, Object>> getAtrz(String edocNo);


	/** 휴가기안서 insert하는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public int createHoli(AtrzLineInfoVO atrzLineInfoVO);


	/** 결재선정보번호를 생성하는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public int createAtrzLineInfoNo(AtrzLineInfoVO atrzLineInfoVO);


	/** 결재선을 insert하는 메서드
	 * @param atrzVOList
	 * @return
	 */
	public int createAtrzLine(List<AtrzVO> atrzVOList);


	/** 참조자를 insert하는 메소드
	 * @param atrzLineInfoVO
	 */
	public int createAtrzRfrnc(List<AtrzRfrncVO> atrzRfrncVOList);


	/** 일반기안문을 insert하는 메서드
	 * @param atrzLineInfoVO
	 */
	public void createDrft(AtrzLineInfoVO atrzLineInfoVO);


	/** 전자문서공통 insert 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public int createEdoc(AtrzLineInfoVO atrzLineInfoVO);


	/** 휴가기안서 detail을 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public List<AtrzLineInfoVO> holiDetail(AtrzLineInfoVO atrzLineInfoVO);



	/** 기안자의 정보를 가져오는 메서드
	 * @param atrzLineInfoVO
	 */
	public Map<String,Object> getEmpInfo(AtrzLineInfoVO atrzLineInfoVO);


	/** 전자결재문서번호를 가져와 해당 문서의 참조자를 출력하는 메서드
	 * @param edocNo
	 * @return
	 */
	public List<Map<String, Object>> getAtrzRfrnc(String edocNo);


	/** 기안서를 결재하는 메서드
	 * @param infoData
	 * @return
	 */
	public int updateAtrz(Map<String, Object> infoData);


	/** 일반기안문의 Deatil을 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public List<AtrzLineInfoVO> drftDetail(AtrzLineInfoVO atrzLineInfoVO);


	/** 결재 진행 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재 진행 문서의 총 개수
	 */
	public int getApprovedTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 결재 진행 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public List<Map<String, Object>> getApproved(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 참조 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public int getAtrzRfrncTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 참조 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public List<Map<String, Object>> getAtrzRfrncBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 결재 완료 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재 완료 문서의 총 개수
	 */
	public int getCompleteTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 결재 완료 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재 완료 문서 리스트
	 */
	public List<Map<String, Object>> getCompleteBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 참조 완료 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 참조 완료 문서의 총 개수
	 */
	public int getAtrzRfrncCompleteTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 참조 완료 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public List<Map<String, Object>> getAtrzRfrncCompleteBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 로그인 한 사원의 기안한 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public int getDraftingTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 로그인 한 사원의 기안한 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public List<Map<String, Object>> getDrafting(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 기안서를 반려하는 메서드
	 * @param infoData
	 * @return 성공시1 실패시0
	 */
	public int rejectAtrz(Map<String, Object> infoData);


	/** 반려문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 반려문서의 총 개수
	 */
	public int getRejectTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 반려문서를 가져오는 메서드
	 * @param pagingVO
	 * @return
	 */
	public List<Map<String, Object>> getRejectBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 반려의견을 가져오는 메서드
	 * @param infoData
	 * @return
	 */
	public Map<String, Object> getRjctRsn(Map<String, Object> infoData);


	/** 반려된 문서를 삭제하는 메서드
	 * @param edocNo
	 * @return 성공시 1 실패시0
	 */
	public int deleteEdoc(String edocNo);


	/** 결재 순서를 가져오는 메서드
	 * @param infoData
	 * @return 결재 순서
	 */
	public int getAtrzSeq(Map<String, Object> infoData);


	/** 다음 결재자 여부를 가져오는 메서드
	 * @param infoData
	 * @return 다음 결재자가 있으면 1 없으면 0
	 */
	public int getAtrzCnt(Map<String, Object> infoData);


	/** 결재할 기안서의 정보를 가져오는 메서드
	 * @param infoData
	 * @return
	 */
	public EdocVO getEdoc(Map<String, Object> infoData);


	/** 다음 결재자를 알림 테이블에 insert하는 메서드
	 * @param edocVO
	 */
	public void createAlarm(EdocVO edocVO);


	/** 다음 결재자의 사원번호를 가져오는 메서드
	 * @param infoData
	 * @return 다음 결재자 사원번호
	 */
	public String getEmpNO(Map<String, Object> infoData);


	/** 다음 결재자를 알림 수신 테이블에 insert하는 메서드
	 * @param alarmRecvVO
	 */
	public void createAlarmRecv(AlarmRecvVO alarmRecvVO);


	/** 마지막 결재여부를 리턴하는 메서드
	 * @param infoData
	 * @return 마지막결재여부가 Y이면 Y, null이면 N
	 */
	public String lastAtrzCheck(Map<String, Object> infoData);


	/** 마지막 결재여부가 'Y' 이면 EDOC의 총결여부를 Y로 insert 해주는 메서드
	 * @param infoData
	 * @return 성공시1 실패시0
	 */
	public int lastEdocY(Map<String, Object> infoData);


	/** 휴가기안서가 총 결재되면, 해당 기안자의 연차일수가 기안서의 신청일수만큼 빼는 메서드
	 * @param infoData
	 * @return
	 */
	public int edupdateEmpCrtHoli(Map<String, Object> infoData);


	/** 참조된 문서의 정보를 가져오는 메서드
	 * @param atrzLineInfoNo
	 * @return
	 */
	public EdocVO getEdocInfo(String atrzLineInfoNo);


	/**
	 * 참조자를 알림 테이블에 insert하는 메서드
	 * @param edocVO
	 */
	public void createRfAlarm(EdocVO edocVO);


	/**
	 * 참조자를 알림 수신 테이블에 insert하는 메서드
	 * @param empNO
	 */
	public void createRfAlarmRecv(String empNO);


	/** 참조자가 null일때 휴가기안서의 Detail을 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public List<AtrzLineInfoVO> holiDetail2(AtrzLineInfoVO atrzLineInfoVO);


	/** 결재선 상태를 update 하는 메서드
	 * @param atrzVOList
	 * @return
	 */
	public int updateAtrzLine(String lineInfoNo);


	/** 전자문서공통테이블을 update하는 메소드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public int updateEdoc(AtrzLineInfoVO atrzLineInfoVO);


	/** 일반기안문을 update하는 메서드(재기안)
	 * @param atrzLineInfoVO
	 */
	public void updateDrft(AtrzLineInfoVO atrzLineInfoVO);


	/** 내 결재 상태를 update하는 메서드
	 * @param lineInfoNo
	 */
	public void updateAtrzLineMe(String lineInfoNo);


	/** 참조 완료 처리 메서드
	 * @param infoData
	 * @return
	 */
	public int atrzRfrncY(Map<String, Object> infoData);


	/** 참조자가 null일때 일반기안서의 Detail을 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public List<AtrzLineInfoVO> drftDetail2(AtrzLineInfoVO atrzLineInfoVO);

}

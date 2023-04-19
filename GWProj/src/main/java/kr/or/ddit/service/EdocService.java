package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AtrzLineInfoVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface EdocService {




	/** 결재할 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재할 문서의 총 개수
	 */
	public int getApproveTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 결재할 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재할 문서 리스트
	 */
	public List<Map<String,Object>> getApprove(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 전자결재문서번호를 가져와 해당 문서의 결재자 및 결재 상황을 출력하는 메서드
	 * @param edocNo
	 * @return 결재자 및 결재정보
	 */
	public List<Map<String,Object>> getAtrz(String edocNo);


	/** 기안서를 insert하는 메서드
	 * @param atrzLineInfoVO
	 * @return 성공시1 실패시 0
	 */
	public int createEdocPost(AtrzLineInfoVO atrzLineInfoVO);


	/** 휴가기안서 detail을 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public List<AtrzLineInfoVO> holiDetail(AtrzLineInfoVO atrzLineInfoVO);



	/** 사원의 잔여휴가일수를 가져오는 메서드
	 * @param empVO
	 * @return
	 */
	public int getCtrHoli(EmpVO empVO);


	/** 기안자 정보를 가져오는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public Map<String,Object> getEmpInfo(AtrzLineInfoVO atrzLineInfoVO);


	/** 참조자 정보를 가져오는 메서드
	 * @param edocNo
	 * @return
	 */
	public List<Map<String, Object>> getAtrzRfrnc(String edocNo);


	/** 기안서를 결재하는 메서드
	 * @param infoData
	 * @return 성공시 1 실패시 0
	 */
	public int updateAtrz(Map<String, Object> infoData);


	/** 일반기안서의 detail을 가져오는 메서드
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
	 * @return 결재 진행 문서 리스트
	 */
	public List<Map<String, Object>> getApproved(PaginationInfoVO<AtrzLineInfoVO> pagingVO);

	/** 참조 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 참조 문서의 총 개수
	 */
	public int getAtrzRfrncTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 참조 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 참조 문서 리스트
	 */
	public List<Map<String, Object>> getAtrzRfrncBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 결재 완료 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 결재 완료 문서
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

	/**  참조 완료 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 참조 완료 문서 리스트
	 */
	public List<Map<String, Object>> getAtrzRfrncCompleteBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 로그인 한 사원의 기안한 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 기안한 문서의 총 개수
	 */
	public int getDraftingTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 내가 기안한 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 기안한 문서 리스트
	 */
	public List<Map<String, Object>> getDrafting(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 기안서를 반려하는 메서드
	 * @param infoData
	 * @return
	 */
	public int rejectAtrz(Map<String, Object> infoData);


	/** 반려 문서의 총 개수를 가져오는 메서드
	 * @param pagingVO
	 * @return 반려 문서의 총 개수
	 */
	public int getRejectTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 반려 문서 리스트를 가져오는 메서드
	 * @param pagingVO
	 * @return 반려 문서 리스트
	 */
	public List<Map<String, Object>> getRejectBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO);


	/** 반려의견을 가져오는 메서드
	 * @param infoData
	 * @return
	 */
	public Map<String, Object> getRjctRsn(Map<String, Object> infoData);


	/** 반려된 문서를 삭제하는 메서드
	 * @param edocNo
	 * @return
	 */
	public int deleteEdoc(String edocNo);


	/** 재기안 메소드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public int edocUpdatePost(AtrzLineInfoVO atrzLineInfoVO);


	/** 참조 완료 처리 메서드
	 * @param infoData
	 * @return
	 */
	public int atrzRfrncY(Map<String, Object> infoData);


}

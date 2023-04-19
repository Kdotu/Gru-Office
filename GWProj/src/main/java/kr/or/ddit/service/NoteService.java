package kr.or.ddit.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.NoteVO;

public interface NoteService {

	/** 받은쪽지함 목록
	 * @param noteVO
	 * @return List<NoteVO>
	 */
	public List<NoteVO> recieveNtList(NoteVO noteVO);

	/** 보낸쪽지함 목록
	 * @param noteVO
	 * @return List<NoteVO>
	 */
	public List<NoteVO> sendNtList(NoteVO noteVO);

	/** 임시보관함 목록
	 * @param noteVO
	 * @return List<NoteVO>
	 */
	public List<NoteVO> keepNtList(NoteVO noteVO);

	/** 쪽지쓰기
	 * @param noteVO
	 * @return int
	 */
	public int writeNote(NoteVO noteVO);

	/** 보관함으로 저장(분류번호 상태값 변경)
	 * @param msgNo
	 * @return int
	 */
	public int changeStatus(String msgNo);

	/** 쪽지 상세보기
	 * @param noteVO
	 * @return NoteVO
	 */
	public NoteVO noteDetail(NoteVO noteVO);

	/** 다중삭제
	 * @param noteVO
	 * @return int
	 */
	public int deletePost(NoteVO noteVO);

	/** 받은(임시)쪽지 상세보기
	 * @param noteVO
	 * @return NoteVO
	 */
	public NoteVO rcvNtDetail(NoteVO noteVO);

	/** 받은메일함 상세보기의 답장
	 * @param noteVO
	 * @return int
	 */
	public int reply(NoteVO noteVO);

	/** 상세보기에서 삭제
	 * @param noteVO
	 * @return int
	 */
	public int detailDelete(NoteVO noteVO);

	/** 쪽지 기본키를 가지고 내용 조회
	 * @param noteVO
	 * @return noteVO
	 */
	public NoteVO deliver(NoteVO noteVO);

	


}













package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.MsgRcvrVO;
import kr.or.ddit.vo.NoteVO;

public interface NoteMapper {

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

	/** 쪽지쓰기1(보낸쪽지)
	 * @param noteVO
	 * @return int
	 */
	public int writeNote(NoteVO noteVO);
	/** 쪽지쓰기1(받는쪽지)
	 * @param msgRcvrVO
	 * @return int
	 */
	public int writeNoteRcvr(MsgRcvrVO msgRcvrVO);

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

	/** 받은메일함 상세보기의 답장(MSG테이블)
	 * @param noteVO
	 * @return int
	 */
	public int reply(NoteVO noteVO);

	/** 받은메일함 상세보기의 답장(MSG_RCVR 테이블)
	 * @param noteVO
	 * @return int
	 */
	public int replyScvr(NoteVO noteVO);
	
	/** 상세보기에서 삭제
	 * @param noteVO
	 * @return int
	 */
	public int detailDelete(NoteVO noteVO);
	

	/** 쪽지 기본키를 가지고 내용 조회
	 * @param noteVO
	 * @return noteVO
	 */
	public NoteVO findCn(NoteVO noteVO);


}

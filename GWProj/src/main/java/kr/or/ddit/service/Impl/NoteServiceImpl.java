package kr.or.ddit.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.NoteMapper;
import kr.or.ddit.service.NoteService;
import kr.or.ddit.vo.MsgRcvrVO;
import kr.or.ddit.vo.NoteVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoteServiceImpl implements NoteService {

	static int cnt = 2;
	@Autowired
	NoteMapper noteMapper;

	@Override
	/** 받은쪽지함 목록
	 * @param noteVO
	 * @return List<NoteVO>
	 */
	public List<NoteVO> recieveNtList(NoteVO noteVO){
		return noteMapper.recieveNtList(noteVO);
	}

	@Override
	/** 보낸쪽지함 목록
	 * @param noteVO
	 * @return List<NoteVO>
	 */
	public List<NoteVO> sendNtList(NoteVO noteVO){
		return noteMapper.sendNtList(noteVO);
	}

	@Override
	/** 임시보관함 목록
	 * @param noteVO
	 * @return List<NoteVO>
	 */
	public List<NoteVO> keepNtList(NoteVO noteVO){
		return noteMapper.keepNtList(noteVO);
	}

	/** 쪽지쓰기
	 * @param noteVO
	 * @return int
	 */
	@Override
	public int writeNote(NoteVO noteVO) {
		//1.보낸 쪽지 처리
//		noteVO.setMsgNo("MSG_NO000" + cnt);
		int result = noteMapper.writeNote(noteVO);

		//2.받는 쪽지 처리
		MsgRcvrVO msgRcvrVO = new MsgRcvrVO();
		for (int i = 0; i < noteVO.getNoteList().size(); i++) {
			//동일한 쪽지번호를 보낸쪽 받는쪽에 셋팅
			msgRcvrVO.setMsgNo(noteVO.getMsgNo());
			//수신자를 배열에서 1명씩 꺼냄
			msgRcvrVO.setEmpNoRcvr(noteVO.getNoteList().get(i).getEmpNoRcvr());
			log.info("rcvr++++ : "+ noteVO.getNoteList().get(i).getEmpNoRcvr());

//			msgRcvrVO.setRcvrMsgNo("MSG_NO000" + cnt);//수신쪽지번호
			//1번이 성공해야 2번 처리됨. 그래서 result는 다시 성공 시 1반환
			result = noteMapper.writeNoteRcvr(msgRcvrVO);
		}
//		//1.보낸 쪽지 처리
//		noteVO.setMsgNo("MSG_NO000" + cnt);
//		int result = noteMapper.writeNote(noteVO);
//		//2.받는 쪽지 처리
//		MsgRcvrVO mrVO = new MsgRcvrVO();
//		for (int i = 0; i < noteVO.getNoteList().size(); i++) {
//			mrVO.setMsgNo(noteVO.getMsgNo());
//			mrVO.setEmpNoRcvr(noteVO.getNoteList().get(i).getEmpNoRcvr());
//			mrVO.setRcvrMsgNo("MSG_NO000" + cnt);
//			result = noteMapper.writeNoteRcvr(mrVO);
//		}
		//성공하면 1반환됨
		return result;
	}

	/** 보관함으로 저장(분류번호 상태값 변경)
	 * @param msgNo
	 * @return int
	 */
	@Override
	public int changeStatus(String msgNo) {
		log.info("service msgNo : " + msgNo);

		String[] arr = null;
		int result = 0;
		arr = msgNo.split(",");

		//다중체크한거 impl에서 반복문으로 돌림.
		for(int i=0; i<arr.length; i++) {
			msgNo = arr[i];
			result += this.noteMapper.changeStatus(msgNo);
		}
		return result;
	}

	/** 쪽지 상세보기
	 * @param noteVO
	 * @return NoteVO
	 */
	@Override
	public NoteVO noteDetail(NoteVO noteVO) {
		log.info(">>noteVO : " + noteVO);

		return noteMapper.noteDetail(noteVO);
	}

	/** 다중삭제
	 * @param noteVO
	 * @return int
	 */
	@Override
	public int deletePost(NoteVO noteVO) {
		log.info("<><>noteVO : " + noteVO);

		List<String> msgNoList = noteVO.getMsgNoArray();

		int result = 0;
		for(String msgNo : msgNoList) {
			noteVO.setMsgNo(msgNo);

			result += noteMapper.deletePost(noteVO);
//			log.info(">>>><<<noteVO : " + noteVO);
		}
		
		log.info(">>>><<<result : " + result);

		return result;
	}

	/** 받은(임시)쪽지 상세보기
	 * @param noteVO
	 * @return NoteVO
	 */
	@Override
	public NoteVO rcvNtDetail(NoteVO noteVO) {
		return noteMapper.rcvNtDetail(noteVO);
	}

	/** 받은메일함 상세보기의 답장
	 * @param noteVO
	 * @return int
	 */
	@Override
	public int reply(NoteVO noteVO) {

		 int result = noteMapper.reply(noteVO);

		 noteVO.setMsgNo(noteVO.getMsgNo());
		 log.info("수신자 전noteVO : " +noteVO);
		 result += noteMapper.replyScvr(noteVO);

		 return result;
	}
	
	/** 상세보기에서 삭제
	 * @param noteVO
	 * @return int
	 */
	@Override
	public int detailDelete(NoteVO noteVO) {
		return noteMapper.detailDelete(noteVO);
	}

	/** 쪽지 기본키를 가지고 내용 조회
	 * @param noteVO
	 * @return noteVO
	 */
	public NoteVO deliver(NoteVO noteVO) {
		log.info("noteVO 개똥이: " + noteVO);
				
		noteVO = noteMapper.findCn(noteVO);
				
		log.info("noteVO 개똥이 after: " + noteVO);
		return noteVO;
	}

	


}









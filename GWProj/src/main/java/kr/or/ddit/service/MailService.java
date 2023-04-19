package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.EmailRcvrVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MailVO;
import kr.or.ddit.vo.WholBVO;

public interface MailService {

	/** 받은메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> recieveEMLList(MailVO mailVO);

	/** 전체메일 건수 가져오는 함수
	 * @param username
	 * @return int값
	 */
	public int totalMailCnt(String username);

	/** 안읽은 메일 건수 가져오는 함수
	 * @param username
	 * @return int값
	 */
	public int unReadMailCnt(String username);

	/** 메일 상세보기
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public MailVO detail(MailVO mailVO);

	/** 메일쓰기
	 * @param mailVO
	 * @return int값
	 */
	public int writePost(MailVO mailVO);

	/** 보낸메일함 목록 띄우기
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> send(MailVO mailVO);

	/** 수신확인 목록 불러오기
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> checkMail(MailVO mailVO);

	/** 받은 메일함 입력
	 * @param emailRcvrVO
	 * @return int
	 */
	public int insertEmailRcvr(EmailRcvrVO emailRcvrVO);

	/** 받은메일 상세보기에서 삭제
	 * @param mailVO
	 * @return int
	 */
	public int delEml(MailVO mailVO);

	/** 중요메일함으로 이동
	 * @param mailVO
	 * @return MailVO
	 */
	public int sendImp(String emlNo);

//	/** 메일 목록 가져오기
//	 * @param mailVO
//	 * @return MailVO
//	 */
//	public MailVO emlList(MailVO mailVO);

	/** 휴지통에 있는 메일 목록 조회
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> selectTrash(MailVO mailVO);

	/** 받은메일 목록에서 다중 삭제(update)
	 * @param mailVO
	 * @return int
	 */
	public int delTrashPost(MailVO mailVO);

	/** 휴지통에서 다중 삭제
	 * @param mailVO
	 * @return int
	 */
	public int delPost(MailVO mailVO);

	/** 휴지통에서 받은메일함으로 복원(이동)
	 * @param mailVO
	 * @return int
	 */
	public int resetPost(MailVO mailVO);

	/** 중요메일함 list
	 * @return List<MailVO>
	 */
	public List<MailVO> impEmlList();

	/** 메일 선택한 태그 update
	 * @param mailVO
	 * @return int
	 */
	public int insertTag(MailVO mailVO);

//	/** 태그 메일 목록
//	 * @param mailVO
//	 * @return List<MailVO>
//	 */
//	public List<MailVO> tagList(MailVO mailVO);

	/** 경영 태그 메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> managementTag(MailVO mailVO);

	/** 참고 태그 메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> referenceTag(MailVO mailVO);

	/** 회계 태그 메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> accontingTag(MailVO mailVO);

	/** 메일 수정하는 메소드
	 * @param mailVO2
	 * @return int
	 */
	public int mailModify(MailVO mailVO2);

	/**
	 * @param empVO
	 * @return 오늘 온 메일의 수
	 */
	public int todayMailCnt(EmpVO empVO);

}







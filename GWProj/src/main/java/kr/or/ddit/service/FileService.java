package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.MailVO;
import kr.or.ddit.vo.SrvyVO;
import kr.or.ddit.vo.TaskVO;
import kr.or.ddit.vo.VhrVO;
import kr.or.ddit.vo.WholBVO;

public interface FileService {

	/**
	 * 회원 파일을 추가하는 메서드
	 * @param empVO
	 * @return
	 */
	public int filecreate(EmpVO empVO);

	/**
	 * 태스크에 파일을 추가하는 메서드
	 * @param taskVO
	 * @return
	 */
	public int taskFilecreate(TaskVO taskVO);

	/**
	 * 설문조사에 파일을 추가하는 메서드
	 * @param srvyVO
	 * @return
	 */
	public int srvyFileCreate(SrvyVO srvyVO);


	/**
	 * 파일 그룹 번호를 입력하여 해당 파일 그룹번호에 속하는 파일 목록을 가져오는 메서드
	 * @param fileGrNo
	 * @return
	 */
	public List<FilesVO> getFilesList(String fileGrNo);

	/**
	 * 차량목록에 파일을 추가하는 메서드
	 * @param vhrVO
	 * @return int
	 */
	public int vhrFileCreate(VhrVO vhrVO);

	/**
	 * 게시판에 파일을 추가하는 메서드
	 * @param wholBVO
	 * @return
	 */
	public int BoardFileCreate(WholBVO wholBVO);

	/**
	 * 메일에 파일을 추가하는 메서드
	 * @param mailVO
	 * @return
	 */
	public int MailFileCreate(MailVO mailVO);


}

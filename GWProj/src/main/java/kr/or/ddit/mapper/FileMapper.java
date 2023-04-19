package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.AtrzLineInfoVO;
import kr.or.ddit.vo.FileGrVO;
import kr.or.ddit.vo.FilesVO;

public interface FileMapper {

	/** 파일 그룹을 insert하는 메서드
	 * @param string
	 * @return
	 */
	public int insertFileGr(FileGrVO fileGrVO);

	/** 파일을 insert하는 메서드
	 * @param atrzLineInfoVO
	 * @return
	 */
	public int insertFiles(List<FilesVO> filesVOList);
	
	/**
	 * 파일 그룹 번호를 입력하여 해당 파일 그룹번호에 속하는 파일 목록을 가져오는 메서드
	 * @param fileGrNo
	 * @return
	 */
	public List<FilesVO> getFilesList(String fileGrNo);
	
	
}

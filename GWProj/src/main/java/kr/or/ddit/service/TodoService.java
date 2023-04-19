package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.TodoVO;

public interface TodoService {

	/**
	 * 할일 목록 받아옴
	 * @param todoVO
	 * @return List<TodoVO>
	 */
	List<TodoVO> getTodo(TodoVO todoVO);

	/**
	 * 체크리스트 목록 받아옴
	 * @param todoVO
	 * @return List<ChkVO>
	 */
	List<ChkVO> getChk(TodoVO todoVO);

	/**
	 * 새 할일 생성
	 * @param todoVO
	 * @param chkVO
	 * @return 생성된 할일 수
	 */
	int createTodo(TodoVO todoVO, ChkVO chkVO);

	/**
	 * 체크리스트 생성 
	 * @param chkVO
	 * @return 생성된 체크리스트 수
	 */
	int createChk(ChkVO chkVO);

	/**
	 * 체크리스트 삭제
	 * @param chkVO
	 * @return 삭제된 체크리스트 수
	 */
	int deleteChk(ChkVO chkVO);

	/**
	 * 할 일 보드 삭제
	 * @param todoVO
	 * @return 삭제된 할 일 보드 수
	 */
	int deleteTodo(TodoVO todoVO);

	/**
	 * 할 일 제목 수정
	 * @param todoVO
	 * @return 수정된 할 일 보드 수
	 */
	int updateTodo(TodoVO todoVO);

	/**
	 * 체크리스트 체크상태 수정
	 * @param chkVO
	 * @return 수정된 체크리스트 수
	 */
	int updateChkYN(ChkVO chkVO);

	/**
	 * 체크리스트 제목 수정
	 * @param chkVO
	 * @return 수정된 체크리스트 수
	 */
	int updateChk(ChkVO chkVO);

}

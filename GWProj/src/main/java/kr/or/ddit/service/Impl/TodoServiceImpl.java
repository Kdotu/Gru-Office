package kr.or.ddit.service.Impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.controller.TodoController;
import kr.or.ddit.mapper.TodoMapper;
import kr.or.ddit.service.TodoService;
import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.TodoVO;
import lombok.extern.slf4j.Slf4j;

@Service
public class TodoServiceImpl implements TodoService {

	@Inject
	private TodoMapper todoMapper;
	
	@Override
	public List<TodoVO> getTodo(TodoVO todoVO) {
		return todoMapper.getTodo(todoVO);
	}

	@Override
	public List<ChkVO> getChk(TodoVO todoVO) {
		return todoMapper.getChk(todoVO);
	}

	@Override
	public int createTodo(TodoVO todoVO, ChkVO chkVO) {
		todoMapper.createTodo(todoVO);
		todoVO = todoMapper.selectMaxTodo();
		String todoNo = todoVO.getTodoNo();
		chkVO.setTodoNo(todoNo);
		return todoMapper.createChk(chkVO);
	}

	@Override
	public int createChk(ChkVO chkVO) {
		return todoMapper.createChk(chkVO);
	}

	@Override
	public int deleteChk(ChkVO chkVO) {
		return todoMapper.deleteChk(chkVO);
	}

	@Override
	public int deleteTodo(TodoVO todoVO) {
		return todoMapper.deleteTodo(todoVO);
	}

	@Override
	public int updateTodo(TodoVO todoVO) {
		return todoMapper.updateTodo(todoVO);
	}

	@Override
	public int updateChkYN(ChkVO chkVO) {
		return todoMapper.updateChkYN(chkVO);
	}

	@Override
	public int updateChk(ChkVO chkVO) {
		return todoMapper.updateChk(chkVO);
	}

}

package kr.or.ddit.service.Impl;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ProjMapper;
import kr.or.ddit.service.ProjService;
import kr.or.ddit.vo.BookmarkVO;
import kr.or.ddit.vo.ChkVO;
import kr.or.ddit.vo.CmntVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.ProjVO;
import kr.or.ddit.vo.PrtpntVO;
import kr.or.ddit.vo.TaskCountVO;
import kr.or.ddit.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjServiceImpl implements ProjService {

	@Inject
	private ProjMapper projMapper;

	@Override
	public List<ProjVO> projList(String username) {
		return projMapper.projList(username);
	}

	@Override
	public int createPost(ProjVO projVO) {
		int res = projMapper.createPost1(projVO);
		projVO.setProjNo(projVO.getProjNo());

		res = projMapper.createPost2(projVO);

		return res;

	}

	@Override
	public int createBookmark(BookmarkVO bookmarkVO) {
		return projMapper.createBookmark(bookmarkVO);
	}

	@Override
	public int deleteBookmark(BookmarkVO bookmarkVO) {
		return projMapper.deleteBookmark(bookmarkVO);
	}

	@Override
	public ProjVO projDetail(ProjVO projVO) {
		return projMapper.projDetail(projVO);
	}

	@Override
	public ProjVO projTaskDetail(String projNo) {
		return projMapper.projTaskDetail(projNo);
	}

	@Override
	public List<PrtpntVO> prtList(PrtpntVO prtpntVO) {
		return projMapper.prtList(prtpntVO);
	}

	@Override
	public int taskCreate(TaskVO taskVO) {
		int res = projMapper.taskMake(taskVO);
		taskVO.setTaskNo(taskVO.getTaskNo());

		res = projMapper.taskPrt(taskVO);

		return res;
	}

	@Override
	public int projDelete(ProjVO projVO) {
		int res = projMapper.projDelete1(projVO);

		res = projMapper.projDelete2(projVO);

		return res;
	}

	@Override
	public int remake(ProjVO projVO) {
		return projMapper.remake(projVO);
	}

	@Override
	public int ingTask(ProjVO projVO) {
		return projMapper.ingTask(projVO);
	}

	@Override
	public TaskCountVO taskCount(ProjVO projVO) {
		return projMapper.taskCount(projVO);
	}

	@Override
	public List<ProjVO> empList() {
		return projMapper.empList();
	}

	@Override
	public int projPrtAdd(PrtpntVO prtpntVO) {
		return projMapper.projPrtAdd(prtpntVO);
	}

	@Override
	public TaskVO taskDetail(TaskVO taskVO) {
		return projMapper.taskDetail(taskVO);
	}

	@Override
	public int chkY(ChkVO chkVO) {
		return projMapper.chkY(chkVO);
	}

	@Override
	public int chkN(ChkVO chkVO) {
		return projMapper.chkN(chkVO);
	}

	@Override
	public int addChkList(ChkVO chkVO) {
		return projMapper.addChkList(chkVO);
	}

	@Override
	public int delChkList(ChkVO chkVO) {
		return projMapper.delChkList(chkVO);
	}

	@Override
	public int createCmnt(CmntVO cmntVO) {
		return projMapper.createCmnt(cmntVO);
	}

	@Override
	public int delCmntList(CmntVO cmntVO) {
		return projMapper.delCmntList(cmntVO);
	}

	@Override
	public int updateCmnt(CmntVO cmntVO) {
		return projMapper.updateCmnt(cmntVO);
	}

	@Override
	public int updateSsts(TaskVO taskVO) {
		return projMapper.updateSsts(taskVO);
	}

	@Override
	public int createExp(TaskVO taskVO) {
		return projMapper.createExp(taskVO);
	}

	@Override
	public int createLabel(TaskVO taskVO) {
		return projMapper.createLabel(taskVO);
	}

	@Override
	public void taskUpdate(TaskVO taskVO) {
		projMapper.taskUpdate(taskVO);

	}

	@Override
	public int deleteFile(FilesVO filesVO) {
		return projMapper.deleteFile(filesVO);
	}

	@Override
	public List<ProjVO> mainProjList(EmpVO empVO) {
		return projMapper.mainProjList(empVO);
	}



}

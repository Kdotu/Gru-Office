package kr.or.ddit.service.Impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.EmpMapper;
import kr.or.ddit.service.EmpService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.SrvyTrprVO;

@Service
public class EmpServiceImpl implements EmpService {

	@Inject
	private EmpMapper empMapper;
	
	@Override
	public EmpVO login(EmpVO empVO) {
		return this.empMapper.login(empVO);
	}
	
	@Override
	public int idCheck(EmpVO empVO) {
		return this.empMapper.idCheck(empVO);
	}

	@Override
	public int join(EmpVO empVO) {
		return this.empMapper.join(empVO);
	}

	@Override
	public List<EmpVO> findInfo(EmpVO empVO) {
		return this.empMapper.findInfo(empVO);
	}

	@Override
	public int modifyEmp(EmpVO empVO) {
		return this.empMapper.modifyEmp(empVO);
	}

	@Override
	public List<EmpVO> getEmpInfo(String empNo) {
		return this.empMapper.getEmpInfo(empNo);
	}

	@Override
	public int authorizeEmp(EmpVO empVO) {
		return this.empMapper.authorizeEmp(empVO);
	}

	@Override
	public List<Map<String, String>> getUpDeptList(EmpVO empVO) {
		return this.empMapper.getUpDeptList(empVO);
	}

	@Override
	public List<SrvyTrprVO> getDeptEmp(String deptNo) {
		return this.empMapper.getDeptEmp(deptNo);
	}

	@Override
	public int updateProfile(EmpVO empVO) {
		return this.empMapper.updateProfile(empVO);
	}
	
	/** 파람으로 받은 empNo로 메일주소 가져오기
	 * @param empNo
	 * @return
	 */
	@Override
	public String findEmlAddr(String empNo) {
		return this.empMapper.findEmlAddr(empNo);
	}

}

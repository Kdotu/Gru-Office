package kr.or.ddit.service.Impl;


import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.OrgMapper;
import kr.or.ddit.mapper.ProjMapper;
import kr.or.ddit.service.OrgService;
import kr.or.ddit.service.ProjService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.ProjVO;

@Service
public class OrgServiceImpl implements OrgService {

	@Inject
	private OrgMapper orgMapper;

	@Override
	public List<EmpVO> orgAdminEmp() {
		return orgMapper.orgAdminEmp();
	}

	@Override
	public List<EmpVO> orgEmp(EmpVO empVO) {
		return orgMapper.orgEmp(empVO);
	}

	@Override
	public EmpVO empModal(EmpVO empVO) {
		return orgMapper.empModal(empVO);
	}

	@Override
	public List<Map<String, String>> searchResult(Map<String, String> parammap) {
		
		return orgMapper.searchResult(parammap); 
	}

	@Override
	public int searchCount(Map<String, String> parammap) {
		return orgMapper.searchCount(parammap);
	}
	
	

	
	

}

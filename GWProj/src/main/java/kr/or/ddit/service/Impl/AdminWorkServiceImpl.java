package kr.or.ddit.service.Impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AdminWorkMapper;
import kr.or.ddit.service.AdminWorkService;
import kr.or.ddit.vo.AuthrtVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.WorkVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminWorkServiceImpl implements AdminWorkService{
	@Inject
	private AdminWorkMapper adminWorkMapper;
	
	//신규사원 생성 시 사원번호 자동생성 
	public EmpVO getEmpNo() {
		return adminWorkMapper.getEmpNo(); 
	}
	
	//직원등록
	public int insertEmp(EmpVO empVO) {
		
		int result = 0;
		
		result += this.adminWorkMapper.insertEmp(empVO);
		
		//empAuthVOList=[
//		AuthrtVO(authrtNo=null, empNo=202301, authrtNm=AUTH_MEM), 
//		AuthrtVO(authrtNo=null, empNo=202301, authrtNm=AUTH_MID), 
//		AuthrtVO(authrtNo=null, empNo=202301, authrtNm=null)],
		List<AuthrtVO> empAuthVOList = empVO.getEmpAuthVOList();
	
		//권한등록
		for(AuthrtVO authrtVO : empAuthVOList) {
			if(authrtVO.getAuthrtNm()!=null) {
				result += this.adminWorkMapper.insertAuthrt(authrtVO);
			}
		}
		
		log.info("result : " + result);
		
		return result;
	}
	
	public List<EmpVO> getEmpList() {
		return this.adminWorkMapper.getEmpList(); 
	}
	
	//재직/퇴사 선택에 따른 사원 리스트 
	public List<EmpVO> empSearch(EmpVO empVO){
		return this.adminWorkMapper.empSearch(empVO); 
	}

	@Override
	public EmpVO updateEmp(EmpVO empVO) {
		return this.adminWorkMapper.updateEmp(empVO); 
	}

	@Override
	public int updateEmpPost(EmpVO empVO) {
		return this.adminWorkMapper.updateEmpPost(empVO);
	}

	@Override
	public int updateAuthPost(List<AuthrtVO> empAuthVOList) {
	
		//해당 직원의 권한 전부 삭제 
		String empNo = empAuthVOList.get(0).getEmpNo(); 
		
		int result = this.adminWorkMapper.deleteAllAuth(empNo); 
		
		// 수정된 권한으로 권한 재부여 
		for(AuthrtVO authrtVO : empAuthVOList) {
			if(authrtVO.getAuthrtNm()!=null) {
				result += this.adminWorkMapper.insertAuthrt(authrtVO);
			}
		}
		
		return result;
	}

	@Override
	public int empExit(Map<String, String> map) {
		return this.adminWorkMapper.empExit(map); 
	}

	@Override
	public int empRejoin(Map<String, String> map) {
		return this.adminWorkMapper.empRejoin(map);
	}

	@Override
	public List<WorkVO> getDeptWork(Map<String, String> map) {
		
		if(map.get("month") != null) {
			//month 
			log.info("널이 아닐때"); 
			return adminWorkMapper.getDept2(map); 
		}else {
			//처음 페이지 요청시 수행되는 쿼리 
			log.info("널일때"); 
			return adminWorkMapper.getDeptStatis(map);
		}
	}

	@Override
	public Map<String, Object> TeamMonth(Map<String, String> map) {
		//널이 아닐 때 
		if(map.get("month") != null) {
			//month 
			log.info("널이 아닐때"); 
			return adminWorkMapper.TeamMonthCNT(map); 
			
		}else {
			//처음 페이지 요청시 수행되는 쿼리 
			log.info("널일때"); 
			return adminWorkMapper.TeamMonth(map);
		}
	}

	@Override
	public Map<String, String> getDeptPerson() {
		return adminWorkMapper.getDeptPerson();
	}

	@Override
	public Map<String, String> getDeptPerson2(Map<String, String> map) {
		return adminWorkMapper.getDeptPerson2(map);
	}

	@Override
	public Map<String, Object> getMonthCNT(Map<String, String> map) {
		return adminWorkMapper.getMonthCNT(map); 
	}

	@Override
	public Map<String, Object> getDeptInfo(Map<String, String> map) {
		
		//부장이 있는지 먼저 검색 
		int result = adminWorkMapper.searchCount(map); 
		
		if(result>0) {
			//부장이 있다면 
			return adminWorkMapper.getDeptInfo(map); 
		}else {
			//부장이 없고 과장이 있다면
			return adminWorkMapper.getDeptInfo2(map); 
		}
		
	}

	@Override
	public Map<String, String> getAllWorkCount(Map<String, String> map) {
		return adminWorkMapper.getAllWorkCount(map); 
	}

	@Override
	public List<Map<String, String>> getDeptWorkCount(Map<String, String> map) {
		return adminWorkMapper.getDeptWorkCount(map); 
	}
	
	
	
	
	

}

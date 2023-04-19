package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.SrvyTrprVO;

public interface EmpMapper {
	
	/**
	 * 회원 아이디를 통해 회원의 전체 정보를 가져옴
	 * @param empVO
	 * @return 등록된 회원의 정보
	 */
	public EmpVO login(EmpVO empVO);
	
	
	/**
	 * 사원번호를 입력받아 사원의 정보를 가져오는 메서드
	 * @param empVO
	 * @return
	 */
	public List<EmpVO> getEmpInfo(String empNo);
	
	/**
	 * 회원가입시 아이디 중복체크를 위해 사용하는 메서드
	 * 아이디 정보를 담은 EmpVO로 등록된 아이디의 정보를 검색
	 * @param empVO
	 * @return (0 : 등록되지 않은 아이디, 1 : 등록된 아이디)
	 */
	public int idCheck(EmpVO empVO);
	
	/** 
	 * 회원가입 시 입력한 정보를  DB에 입력
	 * @param empVO
	 * @return (1: 성공, 0: 실패)
	 */
	public int join(EmpVO empVO);
	
	/**
	 * 아이디 찾기, 비밀번호 찾기에 사용하는 메서드
	 * 이메일 주소로 검색하여 사용자가 입력한 정보(이름, 사원번호)와 동일한지 비교
	 * @param 입력한 이메일 주소가 담긴 empVO
	 * @return 해당 이메일주소를 가진 회원의 정보 (없을 시 null)
	 */
	public List<EmpVO> findInfo(EmpVO empVO);
	
	/** 사원 정보를 수정하는 메서드
	 * @param empVO
	 * @return
	 */
	public int modifyEmp(EmpVO empVO);
	
	/**
	 * 회원가입한 기업관리자 아이디에 권한을 부여하는 메서드
	 * @param empVO
	 * @return
	 */
	public int authorizeEmp(EmpVO empVO);

	
	/**
	 * 사원번호를 입력하여 상위 부서에 속한 부서 목록 가져오는 메서드
	 * @param empVO
	 * @return
	 */
	public List<Map<String, String>> getUpDeptList(EmpVO empVO);


	/**
	 * 부서번호를 입력하여 해당 부서원의 사원번호 리스트를 가져오는 메서드
	 * @param deptNo
	 * @return
	 */
	public List<SrvyTrprVO> getDeptEmp(String deptNo);
	
	
	/**
	 * 회원 프로필 사진 정보를 업데이트
	 * @param empVO 사원번호, 파일그룹번호
	 * @return
	 */
	public int updateProfile(EmpVO empVO);
	
	/** 파람으로 받은 empNo로 메일주소 가져오기
	 * @param empNo
	 * @return
	 */
	public String findEmlAddr(String empNo);
}

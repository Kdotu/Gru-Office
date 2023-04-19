package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class ProjVO {
	//프로젝트번호
	private String projNo;

	//사원번호(등록자)
	private String empNo;

	//사원명(등록자)
	private String empNm;

	//프로젝트제목
	@NotBlank
	private String projTtl;

	//프로젝트등록일
	private Date projRegYmd;

	//프로젝트시작일
	private Date projBgngYmd;

	//프로젝트종료일
	private String projEndYmd;

	//프로젝트상태(=공통코드)
	private String projSsts;

	//프로젝트상태(=공통코드명)
	private String cdNm;

	//로그인 한 회원이 특정 프로젝트에 북마크를 한 카운트(0 : 북마크 안함 / 1 : 북마크 함)
	private int bookmark;

	// 프로젝트  : 참여자 = 1 : N
	private List<PrtpntVO> projPrtpntVOList;

	// 프로젝트  : 태스크 = 1 : N
	private List<TaskVO> projTaskVOList;

	private int[] empNoArray;	//체크박스된 사원 번호들

}

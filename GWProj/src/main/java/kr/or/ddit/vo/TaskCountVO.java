package kr.or.ddit.vo;

import lombok.Data;

@Data
public class TaskCountVO {
	//사원번호(담당자)
	private String empNo;
	
	//사원명(담당자)
	private String empNm;
	
	//태스크 수
	private int allTask;
	
	//대기 수
	private int holdTask;
	
	//진행중 수
	private int ingTask;
	
	//완료 수
	private int endTask;
}

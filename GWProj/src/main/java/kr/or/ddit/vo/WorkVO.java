package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class WorkVO {
	private int workMngNo;
	private String empNo;
	private String workMngBgngDt;
	private String workMngEndDt;
	private int workMngHr;
	private String workMngRegYmd;
	private String workMngSsts;
	private String workMngDtlCn;
	//달 누적 근무시간 
	private String result; 
	private String empNm;
	private String jbpsNm; 
	private String deptNm; 
	
}

package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Work2VO {
	private int workMngNo;
	private String empNo;
	private String workMngBgngDt;
	private String workMngEndDt;
	private int workMngHr;
	private Date workMngRegYmd;
	private String workMngSsts;
	private String workMngDtlCn;
	
	private String weekNum;
	private String dates; 
	private int weekNo;
	private int befWeekNo; 
	private String result; 
	
	
}

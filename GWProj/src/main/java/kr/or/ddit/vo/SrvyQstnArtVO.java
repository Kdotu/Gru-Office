package kr.or.ddit.vo;

import lombok.Data;

// 설문조사 - 질문 보기
@Data
public class SrvyQstnArtVO {
	// 질문보기순서
	private int srvyQstnArtclOrder;
	// 질문번호
	private String srvyQstnNo;
	// 설문조사 번호
	private String srvyNo;
	// 질문보기 내용
	private String srvyQstnArtclCn;
	
}

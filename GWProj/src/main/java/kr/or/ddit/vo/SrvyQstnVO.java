package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 설문조사 - 질문 내용
@Data
public class SrvyQstnVO {
	// 질문번호
	private String srvyQstnNo;
	// 설문조사 번호
	private String srvyNo;
	// 질문내용
	private String srvyQstnCn;
	// 질문유형
	private String srvyQstnType;
	
	// 질문유형이 선택형일 경우
	// 선택형 항목 내용
	List<SrvyQstnArtVO> srvyQstnArtVOList;
}

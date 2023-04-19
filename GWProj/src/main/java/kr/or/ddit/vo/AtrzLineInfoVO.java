package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class AtrzLineInfoVO {
	//결재선정보번호
	private String atrzLineInfoNo;
	//결재선분류
	private String atrzLineInfoClsf;

	//결재선정보 : 결재선 = 1 : N
	private List<AtrzVO> atrzVOList;

	//참조자 선택
	public List<AtrzRfrncVO> atrzRfrncVOList;

	//결재선정보 : 전자문서 공통 = 1 : 1
	private EdocVO edocVO;

}

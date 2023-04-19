package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class TodoVO {
	private String empNo;
	private String todoNo;
	private String todoNm;
	private List<ChkVO> chkVOList;
}

package kr.or.ddit.vo;

import lombok.Data;

//자주쓰는결재선
@Data
public class FavAtrzVO {
	//자주쓰는결재선번호
	private String favAtrzNo;
	//결재순서
	private int favAtrzSeq;
	//등록자
	private String empNoDrft;
	//결재자
	private String empNoAtrz;
	//결재선명
	private String favAtrzNm;
}

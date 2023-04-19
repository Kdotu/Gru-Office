package kr.or.ddit.vo;

import lombok.Data;

@Data
public class HashTagVO {

	// 해시태그번호
	private String hashTagNo;
	// 해시태그 그룹번호
	private String hashTagGrNo;

	// 사용처 (설문조사번호)
	private String usage;
	// 태그명
	private String hashTagNm;

}

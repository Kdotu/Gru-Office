package kr.or.ddit.vo;

import lombok.Data;

@Data
public class EmlTagVO {
	private String emlTagNo;//태그번호
	private String emlTagNm;//메일 태그명
	private String emlTagColor;//태그 색상
	private String dltYn;//삭제여부
	private String empNo;//사원번호
}

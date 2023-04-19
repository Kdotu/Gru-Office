package kr.or.ddit.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class HashTagListVO {
	// 해시태그 번호
	@JsonProperty("value")
	private String hashTagNo;
	// 해시태그명
	@JsonProperty("label")
	private String hashTagNm;

	// 사용여부
	private String useYn;

}

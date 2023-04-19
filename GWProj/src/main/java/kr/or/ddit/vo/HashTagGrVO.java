package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class HashTagGrVO {
	// 해시태그 그룹 번호
	private String hashTagGrNo;
	// 해시태그 사용처
	private String usage;
	
	// 해시태그 목록
	List<HashTagVO> HashTagVOList;
	
}

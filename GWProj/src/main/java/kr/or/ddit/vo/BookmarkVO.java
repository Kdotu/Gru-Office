package kr.or.ddit.vo;

import lombok.Data;

@Data
public class BookmarkVO {
	//사원번호
	private String empNo;
	
	//프로젝번호
	private String projNo;
	
	//자료실번호
	private String arcNo;
	
	//주소록번호
	private int addrNo;
	
	//북마크번호
	private int bookmarkNo;
	
	//체크박스된 주소록 번호들
	private int[] addrNoArray;	
}

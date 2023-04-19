package kr.or.ddit.vo;


import lombok.Data;

@Data
public class FilesVO {
	// 첨부파일번호
	private String fileNo;
	// 첨부파일그룹번호
	private String fileGroupNo;
	// 원본파일명
	private String fileOrgnlNm;
	// 파일저장명
	private String fileStrgNm;
	// 저장경로
	private String fileStrgAddr;
	// 파일크기
	private int fileSz;
	// 썸네일
	private String fileThumb;
	// 컨텐츠 타입
	private String fileType;
	//파일경로
	private String filePlace;
}

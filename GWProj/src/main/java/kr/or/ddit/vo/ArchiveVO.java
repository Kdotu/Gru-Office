package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ArchiveVO {
	//자료번호
	private String arcNo;

	//사원번호
	private String empNo;

	//파일크기
	private int arcFileSz;

	//원본명
	private String arcOrgnlNm;

	//저장명
	private String arcStrgNm;

	//파일타입
	private String arcType;

	//등록일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date arcRegYmd;

	//자료실 그룹명
	private String arcGroupNm;

	//삭제여부
	private String arcDelFl;

	//저장주소
	private String arcStrgAddr;

	//썸내일
	private String arcThumb;

	//업로드 파일
	private MultipartFile[] uploadFile;

	//로그인 한 회원이 특정 자료에 북마크를 한 카운트(0 : 북마크 안함 / 1 : 북마크 함)
	private int bookmark;
}

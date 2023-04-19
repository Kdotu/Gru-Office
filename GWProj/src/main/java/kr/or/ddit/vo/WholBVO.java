package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class WholBVO {
	private String wholBbsNo;//게시판번호
	private String empNo;//사원번호

	private int rnum;//순번
	private String empNm;//사원명

	private String bbsClsfNo;//게시판분류번호
	private String popupYn;//공지팝업여부

	private String empTitle;//이름+직위

	private String fileGroupNo;//첨부파일그룹번호
	private String wholBbsTtl;//게시글 제목
	private String wholBbsCn;//게시글 내용
	private Date wholBbsRegYmd;//게시글 등록일자
	//private int wholBbsGoodCnt;//좋아요수
	private int wholBbsInqCnt;//게시글조회수

	private int cntGood;//좋아요 수

	private String deptNo;//부서번호

	// 게시판  : 댓글 = 1 : N
	private List<CmntVO> boardCmntList;

	//파일
	private MultipartFile[] uploadFile;
	//첨부파일 그룹번호
	private FileGrVO fileGrVO;
	
	private List<FilesVO> filesVOList;
}

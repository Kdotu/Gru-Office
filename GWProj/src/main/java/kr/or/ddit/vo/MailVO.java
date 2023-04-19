package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MailVO {
	private String emlNo;//메일번호
	private String empNo;//사원번호
	private String emlTagNo;//메일태그번호

	private String emlTagcol;//메일태그색상
	private String rcvrYn;//수신확인여부
	private String empNm;//사원명
	
	private String emlRcvrAddr;//수신자메일주소
	
	/*
	 * private int totalMailCnt;//전체메일건수
	 */
	private String emlClsfNo;//메일분류번호
	private String emlTtl;//제목
	private String emlCn;//내용
	private String fileGroupNo;//첨부파일그룹번호
	private Date emlTrsmDt;//전송일시
	private String emlImporYn;//중요여부
	private String emlSndrNo;//발신자 메일주소
	
	private String emlDtStr;//전송일시(중요함)
//	private String emlRcvrNo;//받는사람
//	private String emlRfrncNo;//참조

	private String[] emlNoArray;//체크박스된 메일 번호들

	private Date prev;//비교 일자
	private int rslt;//일자비교기준숫자(같으면:0, 다르면 1)

//	private String emailRcvr;//참조자들(a@jdsakjfkl.dsjkf,b@jdsakjfkl.dsjkf,c@jdsakjfkl.dsjkf)

	//1:N = 메일 : 수신자(참조인)
	private List<EmailRcvrVO> emailRcvrVOList;


	//
	private MultipartFile[] uploadFile;//<input type="file" name="uploadFile" multiple>
//	//상품분류 : 첨부파일 1 :N
//	private List<FilesVO> filesVOList;//첨부파일인 AttachVO를 배열로 만들어줄 변수 만들어줌

	//첨부파일 그룹번호
	private FileGrVO fileGrVO;


}

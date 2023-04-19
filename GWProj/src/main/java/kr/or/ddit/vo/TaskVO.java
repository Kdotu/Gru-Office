package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import javax.annotation.Generated;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.Getter;

@Data
public class TaskVO {
	//태스크번호
	private String taskNo;

	//사원번호(담당자)
	private String empNo;

	//사원명(담당자)
	private String tempno;

	//사원직위(담당자)
	private String empJbps;

	//사원프로필 경로
	private String fileStrgNm;

	//라벨번호
	private String labelNo;

	//라벨번호
	private String labelCol;

	//라벨번호
	private String labelNm;

	//프로젝트번호
	private String projNo;

	//파일그룹번호
	private String fileGroupNo;

	//태스크제목
	private String taskTtl;

	//태스크설명
	private String taskExpln;

	//태스크등록일자
	private Date taskWrtDt;

	//태스크시작일자
	private Date taskBgngDt;

	//태스크종료일자
	private String taskEndDt;

	//태스크상태
	private String taskSsts;

	//태스크 댓글 수
	private int countCmnt;

	//태스크 체크리스트 수
	private int allChk;

	//태스크 체크된 체크리스트 수
	private int clearChk;

	// 태스크  : 참여자 = 1 : N
	private List<PrtpntVO> taskPrtpntVOList;

	// 태스크  : 체크리스트 = 1 : N
	private List<ChkVO> taskChkList;

	// 태스크  : 댓글 = 1 : N
	private List<CmntVO> taskCmntList;

	//파일
	private MultipartFile[] uploadFile;

	//첨부파일 그룹번호
	private FileGrVO fileGrVO;
}

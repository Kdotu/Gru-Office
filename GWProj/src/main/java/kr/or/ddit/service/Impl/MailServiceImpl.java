package kr.or.ddit.service.Impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.controller.FileController;
import kr.or.ddit.mapper.AddressMapper;
import kr.or.ddit.mapper.MailMapper;
import kr.or.ddit.service.MailService;
import kr.or.ddit.vo.AddrVO;
import kr.or.ddit.vo.EmailRcvrVO;
import kr.or.ddit.vo.EmlTagVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FileGrVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.MailVO;
import kr.or.ddit.vo.WholBVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class MailServiceImpl implements MailService {
	@Autowired
	MailMapper mailMapper;

	/**
	 * 받은메일 목록
	 *
	 * @return List<MailVO>
	 */
	@Override
	public List<MailVO> recieveEMLList(MailVO mailVO) {
		return mailMapper.recieveEMLList(mailVO);
	}

	/**
	 * 전체메일 건수 가져오는 함수
	 *
	 * @return int값
	 */
	public int totalMailCnt(String username) {
		return mailMapper.totalMailCnt(username);
	}

	/**
	 * 안읽은 메일 건수 가져오는 함수
	 *
	 * @param username
	 * @return int값
	 */
	public int unReadMailCnt(String username) {
		return mailMapper.unReadMailCnt(username);
	}

	/**
	 * 메일 상세보기
	 *
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public MailVO detail(MailVO mailVO) {
		//메일 읽음 처리
		mailMapper.readMail(mailVO);

		return mailMapper.detail(mailVO);
	}

	/**
	 * 메일쓰기
	 *
	 * @param mailVO
	 * @return int값
	 */
	public int writePost(MailVO mailVO) {
		/*
		 write.jsp의 form데이터에서 옴..
		 mailVO(before) : MailVO(emlNo=null, empNo=null, emlTagNo=null, emlTagcol=null
		 , rcvrYn=null, empNm=null, emlClsfNo=null
		3)
		, emlTtl=제목
		4)
		, emlCn=<p>내용</p>
		, fileGroupNo=null, emlTrsmDt=null, emlImporYn=null, emlSndrNo=null
		1) 받는사람 : 쉼표로 구분
		, emlRcvrNo=a@a.com,b@b.com
		, prev=null, rslt=0
		2) 참조 : 쉼표로 구분
		, emlRfrncNo=c@c.com,d@d.com,e@e.com
		, emailRcvr=null
		, emailRcvrVOList=null)
		 */
		log.info("mailVO(before) : " + mailVO);

		//로그인 한 사람을 받아옴
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		String username = userDetails.getUsername();

		mailVO.setEmpNo(username);
		/*
		 write.jsp의 form데이터에서 옴..
		 mailVO(before) : MailVO(emlNo=null, empNo=202301, emlTagNo=null, emlTagcol=null
		 , rcvrYn=null, empNm=null, emlClsfNo=null
		3)
		, emlTtl=제목
		4)
		, emlCn=<p>내용</p>
		, fileGroupNo=null, emlTrsmDt=null, emlImporYn=null, emlSndrNo=null
		1) 받는사람 : 쉼표로 구분
		, emlRcvrNo=a@a.com,b@b.com
		, prev=null, rslt=0
		2) 참조 : 쉼표로 구분
		, emlRfrncNo=c@c.com,d@d.com,e@e.com
		, emailRcvr=null
		, emailRcvrVOList=null)
		 */
		log.info("mailVO(after) : " + mailVO);

		//1) 보낸 메일함 처리 => 처리 후에는 emlNo가 null이 아닌 값이 채워져 있음
		//1-1) 나는 보냈다(1명)-
		mailVO.setEmlClsfNo("EML_CLSF01");
		int result = mailMapper.writePost(mailVO);


		// mailVO(before) : MailVO(emlNo=EML0313, empNo=202301, emlTagNo=null, emlTagcol=null
		//	 , rcvrYn=null, empNm=null, emlClsfNo=null

		//1-2) 5명은 받았다(2명/3명)EML_CLSF01

		//2-1) 받는사람. 받은 메일함 처리(true@gruit.com,true@gruit.com - 배열로..)
		List<EmailRcvrVO> emlRcvrNoArr = mailVO.getEmailRcvrVOList();
		// List list ==> list.get(0) ==> (ex) a1@naer.com,a2@baver.com,3lkdf@sdfc.com

		String[] receiverArr = emlRcvrNoArr.get(0).getEmlRcvrAddr().split(",");

		// String[] receiveArr = list.get(0).split(",");
		//receiveArr[0]  a1@naer.com
		//receiveArr[1]  a2@baver.com
		//receiveArr[2]  3lkdf@sdfc.com


		log.info("emlRcvrNoArr : " + emlRcvrNoArr);
		log.info("receiverArr : " + receiverArr);

		String emlNo = mailVO.getEmlNo();

		for(String rcvrAddr : receiverArr) {
			EmailRcvrVO emailRcvrVO = new EmailRcvrVO();

			emailRcvrVO.setEmlRcvrAddr(rcvrAddr);
			emailRcvrVO.setEmlNo(mailVO.getEmlNo());
//			emailRcvrVO.setEmlRfrncYn("N");
			emailRcvrVO.setEmlRcptnYn("N");
			emailRcvrVO.setEmlNo(emlNo);

			log.info("emailRcvrVO 이거 : " + emailRcvrVO);

			result += this.mailMapper.insertEmailRcvr(emailRcvrVO);

			//1-2) 5명은 받았다(2명)EML_CLSF01(mail테이블에 받은메일로 처리)
//			emailRcvrVO.setEmlRcvrAddr(emlRcvrNo.getEmlRcvrAddr());
//			mailVO.set
//			mailVO.setEmlClsfNo("EML_CLSF01");
//			log.info("mailVO : " + mailVO);
//			this.mailMapper.writePost(mailVO);
		}






		return result;
	}

	/**
	 * 보낸메일함 목록 띄우기
	 *
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> send(MailVO mailVO) {
		return mailMapper.send(mailVO);
	}

	/**
	 * 수신확인 목록 불러오기
	 *
	 * @param mailVO
	 * @return List<MailVO>
	 */
	public List<MailVO> checkMail(MailVO mailVO) {
		return mailMapper.checkMail(mailVO);
	}

	/** 받은 메일함 입력
	 * @param emailRcvrVO
	 * @return int
	 */
	@Override
	public int insertEmailRcvr(EmailRcvrVO emailRcvrVO) {
		return mailMapper.insertEmailRcvr(emailRcvrVO);
	}

	/** 받은메일 상세보기에서 삭제
	 * @param mailVO
	 * @return int
	 */
	@Override
	public int delEml(MailVO mailVO) {
		return mailMapper.delEml(mailVO);
	}

	/** 중요메일함으로 이동
	 * @param mailVO
	 * @return MailVO
	 */
	@Override
	public int sendImp(String emlNo) {
		return mailMapper.sendImp(emlNo);
	}

//	/** 메일 목록 가져오기
//	 * @param mailVO
//	 * @return MailVO
//	 */
//	@Override
//	public MailVO emlList(MailVO mailVO) {
//		return mailMapper.emlList(mailVO);
//	}

	/** 휴지통에 있는 메일 목록 조회
	 * @param mailVO
	 * @return List<MailVO>
	 */
	@Override
	public List<MailVO> selectTrash(MailVO mailVO){
		return mailMapper.selectTrash(mailVO);
	}

	/** 받은메일 목록에서 다중 삭제
	 * @param mailVO
	 * @return int
	 */
	@Override
	public int delTrashPost(MailVO mailVO) {
		return mailMapper.delTrashPost(mailVO);
	}

	/** 휴지통에서 다중 삭제
	 * @param mailVO
	 * @return int
	 */
	@Override
	public int delPost(MailVO mailVO) {
		return mailMapper.delPost(mailVO);
	}

	/** 휴지통에서 받은메일함으로 복원(이동)
	 * @param mailVO
	 * @return int
	 */
	@Override
	public int resetPost(MailVO mailVO) {
		return mailMapper.resetPost(mailVO);
	}

	/** 중요메일함 list
	 * @return List<MailVO>
	 */
	@Override
	public List<MailVO> impEmlList(){
		return mailMapper.impEmlList();
	}


	/** 메일 선택한 태그 update
	 * @param mailVO
	 * @return int
	 */
	@Transactional
	@Override
	public int insertTag(MailVO mailVO){
		int result = 0;
		//emlTagNo=EML_TAG01
		//emlNoArray=[EML0435, EML0430]
		String[] emlNoArray = mailVO.getEmlNoArray();

		for(String emlNo : emlNoArray) {
			//vo(emlNo=EML0435, empNo=null, emlTagNo=EML_TAG01, emlTagcol=null, rcvrYn=null...
			//vo(emlNo=EML0430, empNo=null, emlTagNo=EML_TAG01, emlTagcol=null, rcvrYn=null...
			MailVO vo = new MailVO();

			vo.setEmlNo(emlNo);
			vo.setEmlTagNo(mailVO.getEmlTagNo());

			result += mailMapper.insertTag(vo);

		}
		 return result;
	}

//	/** 태그 메일 목록
//	 * @param mailVO
//	 * @return List<MailVO>
//	 */
//	public List<MailVO> tagList(MailVO mailVO){
//		return mailMapper.tagList(mailVO);
//	}

	/** 경영 태그 메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	@Override
	public List<MailVO> managementTag(MailVO mailVO){
		return mailMapper.managementTag(mailVO);
	}

	/** 참고 태그 메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	@Override
	public List<MailVO> referenceTag(MailVO mailVO){
		return mailMapper.referenceTag(mailVO);
	}

	/** 회계 태그 메일 목록
	 * @param mailVO
	 * @return List<MailVO>
	 */
	@Override
	public List<MailVO> accontingTag(MailVO mailVO){
		return mailMapper.accontingTag(mailVO);
	}

	/** 메일 수정하는 메소드
	 * @param boardVO
	 * @return int
	 */
	/** 메일 수정하는 메소드
	 * @param mailVO2
	 * @return int
	 */
	@Override
	public int mailModify(MailVO mailVO2) {
		return this.mailMapper.mailModify(mailVO2);
	}

	/**
	 * 오늘 온 메일의 수
	 */
	@Override
	public int todayMailCnt(EmpVO empVO) {
		return this.mailMapper.todayMailCnt(empVO);
	}
	

}










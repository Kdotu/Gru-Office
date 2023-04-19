package kr.or.ddit.service.Impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.controller.FileController;
import kr.or.ddit.mapper.EdocMapper;
import kr.or.ddit.mapper.FileMapper;
import kr.or.ddit.service.EdocService;
import kr.or.ddit.vo.AlarmRecvVO;
import kr.or.ddit.vo.AtrzLineInfoVO;
import kr.or.ddit.vo.AtrzRfrncVO;
import kr.or.ddit.vo.AtrzVO;
import kr.or.ddit.vo.EdocVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.FileGrVO;
import kr.or.ddit.vo.FilesVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Service
public class EdocServiceImple implements EdocService {

	@Autowired
	EdocMapper edocmapper;
	@Autowired
	FileMapper fileMapper;

	@Override
	public int getCtrHoli(EmpVO empVO) {
		return this.edocmapper.getCtrHoli(empVO);
	}

	@Override
	public int getApproveTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getApproveTotal(pagingVO);
	}

	@Override
	public List<Map<String,Object>> getApprove(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getApprove(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getAtrz(String edocNo) {
		return this.edocmapper.getAtrz(edocNo);
	}


	@Transactional
	@Override
	public int createEdocPost(AtrzLineInfoVO atrzLineInfoVO) {
		//1) 결재선정보 insert
		this.edocmapper.createAtrzLineInfoNo(atrzLineInfoVO);

		//2) 결재선 insert
		List<AtrzVO> atrzVOList = atrzLineInfoVO.getAtrzVOList();
		for(AtrzVO atrzVO : atrzVOList ) {
			atrzVO.setAtrzLineInfoNo(atrzLineInfoVO.getAtrzLineInfoNo()); //atrzLineInfoNo 값을 설정해 줌
		}
		this.edocmapper.createAtrzLine(atrzVOList);

		//3)결재 참조자 insert
		int result3 = 0;
			List<AtrzRfrncVO> atrzRfrncVOList = new ArrayList<AtrzRfrncVO>();
			if(atrzLineInfoVO.getAtrzRfrncVOList() != null) {
				atrzRfrncVOList = atrzLineInfoVO.getAtrzRfrncVOList();
				for(AtrzRfrncVO atrzRfrncVO : atrzRfrncVOList) {
					atrzRfrncVO.setAtrzLineInfoNo(atrzLineInfoVO.getAtrzLineInfoNo());
				}
				result3 = this.edocmapper.createAtrzRfrnc(atrzRfrncVOList);
			}


		//4) 파일 insert
		MultipartFile[] multipartFiles = atrzLineInfoVO.getEdocVO().getUploadFile();
		if(multipartFiles != null) {
			String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";
			File uploadPath = new File(uploadFolder,FileController.getFolder());

			//만약 연/월/일 해당 폴더가 없다면 생성
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}
			List<FilesVO> filesVOList = new ArrayList<>();

			for(MultipartFile file : multipartFiles) {
				FilesVO vo = new FilesVO();
				//1-1)파일그룹INSERT

				//원본파일명 및 파일타입 꺼내기
				String originuploadFileName = file.getOriginalFilename();
				String contextType = file.getContentType();

				//파일명 중복 방지
				UUID uuid = UUID.randomUUID();

				//uuid+원본파일명 =>파일네임에 덧씌어주기
				String uploadFileName = uuid.toString() +"_"+originuploadFileName;
				File saveFile = new File(uploadPath,uploadFileName);

				try {
					file.transferTo(saveFile);
					try { //만약 image파일이라면 썸내일을 설정
						String contentType = Files.probeContentType(saveFile.toPath());
						log.info("contentType : "+contentType);

						if(contentType!=null && contentType.startsWith("image")) {
							FileOutputStream thumbnail = new FileOutputStream(
										new File(uploadPath,"s_"+uploadFileName)
									);
							Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
							thumbnail.close();
						}
					}catch(Exception e) {
						e.printStackTrace();
					}


				}catch(IllegalStateException e) {
					log.error(e.getMessage());
				}catch(IOException e) {
					log.error(e.getMessage());
				}

				Long l = file.getSize();
				String filename= "/" + FileController.getFolder().replace("\\","/")+"/"+uploadFileName;
				vo.setFileOrgnlNm(originuploadFileName);
				vo.setFileStrgAddr(uploadPath.toString());
				vo.setFileStrgNm(filename);
				vo.setFileSz(l.intValue());
				vo.setFileType(contextType);
				String thumbFileName =  "/" + FileController.getFolder().replace("\\","/")+"/"+"s_"+uploadFileName;
				vo.setFileThumb(thumbFileName);

				filesVOList.add(vo);
	 		}

			FileGrVO fileGrVO = new FileGrVO();
			atrzLineInfoVO.getEdocVO().setFileGrVO(fileGrVO);

			atrzLineInfoVO.getEdocVO().getFileGrVO().setFilesList(filesVOList);
			atrzLineInfoVO.getEdocVO().getFileGrVO().setFileGroupNm("전자결재");

			//파일그룹 insert
			this.fileMapper.insertFileGr(atrzLineInfoVO.getEdocVO().getFileGrVO());
			atrzLineInfoVO.getEdocVO().setFileGroupNo(atrzLineInfoVO.getEdocVO().getFileGrVO().getFileGroupNo());
			for(FilesVO vo : filesVOList) {
				vo.setFileGroupNo(atrzLineInfoVO.getEdocVO().getFileGrVO().getFileGroupNo());
			}

			//파일 insert
			int result55 = fileMapper.insertFiles(filesVOList);
		}

		//5)전자문서공통 insert
		int result4 = this.edocmapper.createEdoc(atrzLineInfoVO);

		//6)해당 기안서 insert
		String form = atrzLineInfoVO.getEdocVO().getEdocFormClsf();
		if("EDOCFORM01".equals(form) || "EDOCFORM03".equals(form) || "EDOCFORM04".equals(form) ||
				"EDOCFORM05".equals(form) || "EDOCFORM07".equals(form)) { //일반 기안서
			this.edocmapper.createDrft(atrzLineInfoVO);
		}

		if("EDOCFORM06".equals(form)) { // 휴가기안서
			this.edocmapper.createHoli(atrzLineInfoVO);
		}

		//참조자가 테이블에 등록되면 알림목록에 insert
		if(result3 > 0) {
			for(int i=0; i<atrzRfrncVOList.size(); i++) {
				String empNO = atrzRfrncVOList.get(i).getEmpNo();
				String atrzLineInfoNo = atrzRfrncVOList.get(i).getAtrzLineInfoNo();

				//ATRZ_LINE_INFO_NO 사용해서 EDOC에서 정보 가져오기
				EdocVO edocVO = new EdocVO();
				edocVO = this.edocmapper.getEdocInfo(atrzLineInfoNo);

				//알림목록에 insert
				this.edocmapper.createRfAlarm(edocVO);

				//알림 수신자목록에 insert
				this.edocmapper.createRfAlarmRecv(empNO);
			}
		}
		return result4;
	}

	@Override
	public List<AtrzLineInfoVO> holiDetail(AtrzLineInfoVO atrzLineInfoVO) {
		if(atrzLineInfoVO.getAtrzRfrncVOList() != null) {
			return this.edocmapper.holiDetail(atrzLineInfoVO);
		}else { //참조자가 null일때
			return this.edocmapper.holiDetail2(atrzLineInfoVO);
		}
	}

	@Override
	public Map<String,Object> getEmpInfo(AtrzLineInfoVO atrzLineInfoVO) {
		return this.edocmapper.getEmpInfo(atrzLineInfoVO);

	}

	@Override
	public List<Map<String, Object>> getAtrzRfrnc(String edocNo) {
		return this.edocmapper.getAtrzRfrnc(edocNo);
	}

	@Override
	public int updateAtrz(Map<String, Object> infoData) {
		int result = this.edocmapper.updateAtrz(infoData);
		//1) 마지막 결재여부 리턴(lastAtrzCheck) : Y 또는 N이 리턴됨
		String YN = this.edocmapper.lastAtrzCheck(infoData);
		if(YN.equals("Y")) { 	//2) 마지막 결재여부가 'Y' 이면은(lastAtrzY)
			result += this.edocmapper.lastEdocY(infoData);
			result += this.edocmapper.edupdateEmpCrtHoli(infoData);
		}

		//atrzSeq 가져오기
		int atrzSeq = this.edocmapper.getAtrzSeq(infoData);
		infoData.put("atrzSeq", atrzSeq);
		//다음 결재자 있는지 여부 확인
		int atrzCnt = this.edocmapper.getAtrzCnt(infoData);
		//있다면
		if(atrzCnt > 0) {
			//기안서 정보 가져오기
			EdocVO edocVO = this.edocmapper.getEdoc(infoData);
			//알림목록 테이블에 등록
			this.edocmapper.createAlarm(edocVO);
			//결재자 사원번호 가져오기
			String empNo = this.edocmapper.getEmpNO(infoData);
			AlarmRecvVO alarmRecvVO = new AlarmRecvVO();
			alarmRecvVO.setEmpNo(empNo);
			//알림수신자 테이블에 등록
			this.edocmapper.createAlarmRecv(alarmRecvVO);
		}
		return result;
	}

	@Override
	public List<AtrzLineInfoVO> drftDetail(AtrzLineInfoVO atrzLineInfoVO) {

		//참조자가 존재할 시
		if(atrzLineInfoVO.getAtrzRfrncVOList() != null) {
			return this.edocmapper.drftDetail(atrzLineInfoVO);
		}else { //참조자가 없을 시
			return this.edocmapper.drftDetail2(atrzLineInfoVO);
		}
	}

	@Override
	public int getApprovedTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getApprovedTotal(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getApproved(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getApproved(pagingVO);
	}

	@Override
	public int getAtrzRfrncTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getAtrzRfrncTotal(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getAtrzRfrncBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getAtrzRfrncBox(pagingVO);
	}


	@Override
	public int getCompleteTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getCompleteTotal(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getCompleteBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getCompleteBox(pagingVO);
	}

	@Override
	public int getAtrzRfrncCompleteTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getAtrzRfrncCompleteTotal(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getAtrzRfrncCompleteBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getAtrzRfrncCompleteBox(pagingVO);
	}

	@Override
	public int getDraftingTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getDraftingTotal(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getDrafting(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getDrafting(pagingVO);
	}

	@Override
	public int rejectAtrz(Map<String, Object> infoData) {
		return this.edocmapper.rejectAtrz(infoData);
	}

	@Override
	public int getRejectTotal(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getRejectTotal(pagingVO);
	}

	@Override
	public List<Map<String, Object>> getRejectBox(PaginationInfoVO<AtrzLineInfoVO> pagingVO) {
		return this.edocmapper.getRejectBox(pagingVO);
	}

	@Override
	public Map<String, Object> getRjctRsn(Map<String, Object> infoData) {
		return this.edocmapper.getRjctRsn(infoData);
	}

	@Override
	public int deleteEdoc(String edocNo) {
		return this.edocmapper.deleteEdoc(edocNo);
	}



	@Override
	public int edocUpdatePost(AtrzLineInfoVO atrzLineInfoVO) {
		String lineInfoNo = atrzLineInfoVO.getAtrzLineInfoNo();

		this.edocmapper.updateAtrzLineMe(lineInfoNo);
		this.edocmapper.updateAtrzLine(lineInfoNo);

		//파일업로드
		MultipartFile[] multipartFiles = atrzLineInfoVO.getEdocVO().getUploadFile();
		if(multipartFiles != null) {
			String uploadFolder ="C:\\eGovFrameDev-3.10.0-64bit\\workspace\\GWProj\\src\\main\\webapp\\resources\\upload";
			File uploadPath = new File(uploadFolder,FileController.getFolder());
			log.info("uploadPath : "+uploadPath);
			//만약 연/월/일 해당 폴더가 없다면
			if(uploadPath.exists()==false) {
				uploadPath.mkdirs();
			}
			List<FilesVO> filesVOList = new ArrayList<>();

			for(MultipartFile file : multipartFiles) {
				FilesVO vo = new FilesVO();
				//1-1)파일그룹INSERT

				String originuploadFileName = file.getOriginalFilename();
				String contextType = file.getContentType();

				//파일명 중복 방지
				UUID uuid = UUID.randomUUID();

				//uuid+원본파일명 =>파일네임에 덧씌어주기
				String uploadFileName = uuid.toString() +"_"+originuploadFileName;

				//어디에?무엇을? 계획을 세우자
				File saveFile = new File(uploadPath,uploadFileName);

				try {
					file.transferTo(saveFile);
					try { //만약 image파일이라면 썸내일을 설정
						String contentType = Files.probeContentType(saveFile.toPath());
						log.info("contentType : "+contentType);

						if(contentType!=null && contentType.startsWith("image")) {
							FileOutputStream thumbnail = new FileOutputStream(
										new File(uploadPath,"s_"+uploadFileName)
									);
							//썸내일 생성
							Thumbnailator.createThumbnail(file.getInputStream(),thumbnail,100,100);
							thumbnail.close();
						}
					}catch(Exception e) {
						e.printStackTrace();
					}

				}catch(IllegalStateException e) {
					log.error(e.getMessage());
				}catch(IOException e) {
					log.error(e.getMessage());
				}

				Long l = file.getSize();
				String filename= "/" + FileController.getFolder().replace("\\","/")+"/"+uploadFileName;
				vo.setFileOrgnlNm(originuploadFileName);
				vo.setFileStrgAddr(uploadPath.toString());
				vo.setFileStrgNm(filename);
				vo.setFileSz(l.intValue());
				vo.setFileType(contextType);
				String thumbFileName =  "/" + FileController.getFolder().replace("\\","/")+"/"+"s_"+uploadFileName;
				vo.setFileThumb(thumbFileName);

				filesVOList.add(vo);
	 		}
			FileGrVO fileGrVO = new FileGrVO();
			atrzLineInfoVO.getEdocVO().setFileGrVO(fileGrVO);

			atrzLineInfoVO.getEdocVO().getFileGrVO().setFilesList(filesVOList);

			atrzLineInfoVO.getEdocVO().getFileGrVO().setFileGroupNm("전자결재");
			//파일그룹 insert
			this.fileMapper.insertFileGr(atrzLineInfoVO.getEdocVO().getFileGrVO());
			atrzLineInfoVO.getEdocVO().setFileGroupNo(atrzLineInfoVO.getEdocVO().getFileGrVO().getFileGroupNo());

			for(FilesVO vo : filesVOList) {
				vo.setFileGroupNo(atrzLineInfoVO.getEdocVO().getFileGrVO().getFileGroupNo());
			}

			//파일 insert
			fileMapper.insertFiles(filesVOList);
		}

		//5)전자문서공통 insert
		int result4 = this.edocmapper.updateEdoc(atrzLineInfoVO);

		//6)기안서 insert
		String form = atrzLineInfoVO.getEdocVO().getEdocFormClsf();
		if("EDOCFORM01".equals(form) || "EDOCFORM03".equals(form) || "EDOCFORM04".equals(form) ||
				"EDOCFORM05".equals(form) || "EDOCFORM07".equals(form)) {
			this.edocmapper.updateDrft(atrzLineInfoVO);
		}

		return result4;
	}

	@Override
	public int atrzRfrncY(Map<String, Object> infoData) {
		return this.edocmapper.atrzRfrncY(infoData);
	}


}

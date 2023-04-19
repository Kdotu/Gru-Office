package kr.or.ddit.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MtgrmVO;
import kr.or.ddit.vo.RoomRsvtVO;
import kr.or.ddit.vo.VhrRsvtVO;
import kr.or.ddit.vo.VhrVO;

@Service
public interface ReserveService {

	/**
	 * 자원관리의 전체 차량목록을 불러옴
	 * @return List<VhrVO>
	 */
	List<VhrVO> getVhrList();

	/**
	 * 차량 한 대의 상세정보를 불러옴
	 * @param vhrVO
	 * @return VhrVO
	 */
	VhrVO getVhr(VhrVO vhrVO);

	/**
	 * 차량 상세에서 선택된 차량의 예약목록을 불러옴
	 * @param vhrVO
	 * @return List<VhrRsvtVO>
	 */
	List<VhrRsvtVO> getCarReserve(VhrVO vhrVO);

	/**
	 * 나의 회의실 예약목록을 불러옴
	 * @param roomRsvtVO
	 * @return List<RoomRsvtVO>
	 */
	List<RoomRsvtVO> getMyresRoom(RoomRsvtVO roomRsvtVO);

	/**
	 * 나의 차량예약목록을 불러옴
	 * @param vhrRsvtVO
	 * @return List<VhrRsvtVO> 
	 */
	List<VhrRsvtVO> getMyresVhr(VhrRsvtVO vhrRsvtVO);

	/**
	 * 회의실 예약 삭제
	 * @param roomRsvtVO
	 * @return 삭제된 예약 행 수
	 */
	int deleteRoomRes(RoomRsvtVO roomRsvtVO);

	/**
	 * 전체 회의실 정보
	 * @return List<MtgrmVO>
	 */
	List<MtgrmVO> getMtgrm();

	/**
	 * 전체 차량 정보
	 * @return
	 */
	List<VhrVO> getAllVhr();

	/**
	 * 새로운 차량 생성
	 * @param vhrVO
	 * @return 생성된 차량 수
	 */
	int createCar(VhrVO vhrVO);

	/**
	 * 새로운 회의실 생성
	 * @param mtgrmVO
	 * @return 생성된 회의실 수
	 */
	int createRoom(MtgrmVO mtgrmVO);

	/**
	 * 회의실 정보 수정
	 * @param mtgrmVO
	 * @return 수정된 회의실 수
	 */
	int updateRoom(MtgrmVO mtgrmVO);

	/**
	 * 회의실 삭제
	 * @param mtgrmVO
	 * @return 삭제된 회의실 수
	 */
	int deleteRoom(MtgrmVO mtgrmVO);

	/**
	 * 차량 삭제
	 * @param vhrVO
	 * @return 삭제된 차량 수
	 */
	int deleteCar(VhrVO vhrVO);

	/**
	 * 차량 정보 수정
	 * @param vhrVO
	 * @return 수정된 차량 수
	 */
	int updateCar(VhrVO vhrVO);

	/**
	 * 내가 예약한 회의실 정보
	 * @return List<RoomRsvtVO>
	 */
	List<RoomRsvtVO> getAllMyresRoom();

	/**
	 * 내가 예약한 차량 정보
	 * @return List<VhrRsvtVO> 
	 */
	List<VhrRsvtVO> getAllMyresVhr();

	/**
	 * 새로운 차량 예약 생성
	 * @param vhrRsvtVO
	 * @return 새로 생성된 차량 예약 수
	 */
	int createCarReserve(VhrRsvtVO vhrRsvtVO);

	/**
	 * 차량 예약 삭제
	 * @param vhrRsvtVO
	 * @return 삭제된 차량 예약 수
	 */
	int deleteCarRes(VhrRsvtVO vhrRsvtVO);

	/**
	 * 관리자의 차량 예약내용 수정
	 * @param vhrRsvtVO
	 * @return 수정된 예약 수
	 */
	int updateCarRes(VhrRsvtVO vhrRsvtVO);

	/**
	 * 새로운 회의실 예약 생성
	 * @param roomRsvtVO
	 * @return 생성된 회의실 예약 수
	 */
	int createRoomReserve(RoomRsvtVO roomRsvtVO);

	/**
	 * 선택된 날짜의 예약된 회의실 정보 검색
	 * @param today
	 * @return List<RoomRsvtVO> 
	 */
	List<RoomRsvtVO> getAllresRoomForDay(String today);

	/**
	 * 기한이 지났음에도 아직 반납되지 않은 차량 정보
	 * @return List<VhrRsvtVO>
	 */
	List<VhrRsvtVO> getNotReturnMyresVhr();

	/**
	 * 오늘 내가 예약해둔 전체 회의실 수
	 * @param empVO
	 * @return int로 리턴
	 */
	int resRoomTodayCount(EmpVO empVO);

	/**
	 * 오늘 기준으로 일주일 후까지 예약이 예정된 차량들의 정보
	 * @param empVO
	 * @return List<VhrRsvtVO> 
	 */
	List<VhrRsvtVO> resCarTodayList(EmpVO empVO);
	
	/**
	 * 전체 차량 ID의 최대 번호 검색
	 * @return String 형태로 리턴
	 */
	String getVhrNo();

}

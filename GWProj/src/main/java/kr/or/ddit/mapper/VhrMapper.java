package kr.or.ddit.mapper;

import java.util.Date;
import java.util.List;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MtgrmVO;
import kr.or.ddit.vo.RoomRsvtVO;
import kr.or.ddit.vo.VhrRsvtVO;
import kr.or.ddit.vo.VhrVO;

public interface VhrMapper {

	List<VhrVO> getVhrList();

	VhrVO getVhr(VhrVO vhrVO);

	List<VhrRsvtVO> getCarReserve(VhrVO vhrVO);

	List<RoomRsvtVO> getMyresRoom(RoomRsvtVO roomRsvtVO);

	List<VhrRsvtVO> getMyresVhr(VhrRsvtVO vhrRsvtVO);

	int deleteRoomRes(RoomRsvtVO roomRsvtVO);

	List<MtgrmVO> getMtgrm();

	List<VhrVO> getAllVhr();

	int createCar(VhrVO vhrVO);

	int createRoom(MtgrmVO mtgrmVO);

	int updateRoom(MtgrmVO mtgrmVO);

	int deleteRoom(MtgrmVO mtgrmVO);

	int deleteCar(VhrVO vhrVO);

	int updateCar(VhrVO vhrVO);

	List<RoomRsvtVO> getAllMyresRoom();

	List<VhrRsvtVO> getAllMyresVhr();

	int createCarReserve(VhrRsvtVO vhrRsvtVO);

	int deleteCarRes(VhrRsvtVO vhrRsvtVO);

	int updateCarRes(VhrRsvtVO vhrRsvtVO);

	int createRoomReserve(RoomRsvtVO roomRsvtVO);

	List<RoomRsvtVO> getAllresRoomForDay(String today);

	List<VhrRsvtVO> getNotReturnMyresVhr();

	int resRoomTodayCount(EmpVO empVO);

	List<VhrRsvtVO> resCarTodayList(EmpVO empVO);
	
	String getVhrNo();

}

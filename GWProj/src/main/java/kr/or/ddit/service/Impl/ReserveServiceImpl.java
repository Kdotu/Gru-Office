package kr.or.ddit.service.Impl;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.VhrMapper;
import kr.or.ddit.service.ReserveService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.MtgrmVO;
import kr.or.ddit.vo.RoomRsvtVO;
import kr.or.ddit.vo.VhrRsvtVO;
import kr.or.ddit.vo.VhrVO;

@Service
public class ReserveServiceImpl implements ReserveService {

	@Inject
	VhrMapper vhrMapper;

	@Override
	public List<VhrVO> getVhrList() {
		return vhrMapper.getVhrList();
	}

	@Override
	public VhrVO getVhr(VhrVO vhrVO) {
		return vhrMapper.getVhr(vhrVO);
	}

	@Override
	public List<VhrRsvtVO> getCarReserve(VhrVO vhrVO) {
		return vhrMapper.getCarReserve(vhrVO);
	}

	@Override
	public List<RoomRsvtVO> getMyresRoom(RoomRsvtVO roomRsvtVO) {
		return vhrMapper.getMyresRoom(roomRsvtVO);
	}

	@Override
	public List<VhrRsvtVO> getMyresVhr(VhrRsvtVO vhrRsvtVO) {
		return vhrMapper.getMyresVhr(vhrRsvtVO);
	}

	@Override
	public int deleteRoomRes(RoomRsvtVO roomRsvtVO) {
		return vhrMapper.deleteRoomRes(roomRsvtVO);
	}

	@Override
	public List<MtgrmVO> getMtgrm() {
		return vhrMapper.getMtgrm();
	}

	@Override
	public List<VhrVO> getAllVhr() {
		return vhrMapper.getAllVhr();
	}

	@Override
	public int createCar(VhrVO vhrVO) {
		return vhrMapper.createCar(vhrVO);
	}

	@Override
	public int updateCar(VhrVO vhrVO) {
		return vhrMapper.updateCar(vhrVO);
	}

	@Override
	public int deleteCar(VhrVO vhrVO) {
		return vhrMapper.deleteCar(vhrVO);
	}

	@Override
	public int createRoom(MtgrmVO mtgrmVO) {
		return vhrMapper.createRoom(mtgrmVO);
	}

	@Override
	public int updateRoom(MtgrmVO mtgrmVO) {
		return vhrMapper.updateRoom(mtgrmVO);
	}

	@Override
	public int deleteRoom(MtgrmVO mtgrmVO) {
		return vhrMapper.deleteRoom(mtgrmVO);
	}

	@Override
	public List<RoomRsvtVO> getAllMyresRoom() {
		return vhrMapper.getAllMyresRoom();
	}

	@Override
	public List<VhrRsvtVO> getAllMyresVhr() {
		return vhrMapper.getAllMyresVhr();
	}

	@Override
	public int createCarReserve(VhrRsvtVO vhrRsvtVO) {
		return vhrMapper.createCarReserve(vhrRsvtVO);
	}

	@Override
	public int deleteCarRes(VhrRsvtVO vhrRsvtVO) {
		return vhrMapper.deleteCarRes(vhrRsvtVO);
	}

	@Override
	public int updateCarRes(VhrRsvtVO vhrRsvtVO) {
		return vhrMapper.updateCarRes(vhrRsvtVO);
	}

	@Override
	public int createRoomReserve(RoomRsvtVO roomRsvtVO) {
		return vhrMapper.createRoomReserve(roomRsvtVO);
	}

	@Override
	public List<RoomRsvtVO> getAllresRoomForDay(String today) {
		return vhrMapper.getAllresRoomForDay(today);
	}

	@Override
	public List<VhrRsvtVO> getNotReturnMyresVhr() {
		return vhrMapper.getNotReturnMyresVhr();
	}

	@Override
	public int resRoomTodayCount(EmpVO empVO) {
		return vhrMapper.resRoomTodayCount(empVO);
	}

	@Override
	public List<VhrRsvtVO> resCarTodayList(EmpVO empVO) {
		return vhrMapper.resCarTodayList(empVO);
	}

	@Override
	public String getVhrNo() {
		return vhrMapper.getVhrNo();
	}

}

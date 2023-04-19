package kr.or.ddit.service.Impl;



import java.util.List;

import javax.inject.Inject;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AlarmMapper;
import kr.or.ddit.service.AlarmService;
import kr.or.ddit.vo.AlarmListVO;
import kr.or.ddit.vo.AlarmRecvVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AlarmServiceImpl implements AlarmService {

	@Inject
	private AlarmMapper alarmMapper;

	@Override
	public int alarmCount(String username) {
		return this.alarmMapper.alarmCount(username);
	}

	@Override
	public List<AlarmListVO> alarmList(String username) {
		return this.alarmMapper.alarmList(username);
	}

	@Override
	public int deleteAlarm(AlarmListVO alarmListVO) {
		return this.alarmMapper.deleteAlarm(alarmListVO);
	}

	@Override
	public int deleteAllAlarm(AlarmListVO alarmListVO) {
		return this.alarmMapper.deleteAllAlarm(alarmListVO);
	}

	@Override
	public int checkAlarm(AlarmRecvVO alarmRecvVO) {
		return this.alarmMapper.checkAlarm(alarmRecvVO);
	}

	@Override
	public List<AlarmListVO> mainHeader(String username) {
		return this.alarmMapper.mainHeader(username);
	}





}

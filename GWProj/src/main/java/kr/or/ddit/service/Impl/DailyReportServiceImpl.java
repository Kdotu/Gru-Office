package kr.or.ddit.service.Impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.DailyReportMapper;
import kr.or.ddit.service.DailyReportService;
import kr.or.ddit.vo.DailyReportVO;

@Service
public class DailyReportServiceImpl implements DailyReportService{

	@Inject
	DailyReportMapper dailyReportMapper;

	@Override
	public List<DailyReportVO> getAllList(Map<String,String> reportMap) {
		return this.dailyReportMapper.getAllList(reportMap);
	}

	@Override
	public List<DailyReportVO> getDeptList(Map<String,String> reportMap) {
		return this.dailyReportMapper.getDeptList(reportMap);
	}

	@Override
	public List<DailyReportVO> getDeptListAdmin(Map<String, String> reportMap) {
		return this.dailyReportMapper.getDeptListAdmin(reportMap);
	}

	@Override
	public int createReport(DailyReportVO dailyRVO) {
		return this.dailyReportMapper.createReport(dailyRVO);
	}

	@Override
	public int modifyReport(DailyReportVO dailyRVO) {
		return this.dailyReportMapper.modifyReport(dailyRVO);
	}

	@Override
	public DailyReportVO dateList(HashMap<String, String> dateMap) {
		return this.dailyReportMapper.dateList(dateMap);
	}

	@Override
	public int checkReport(DailyReportVO dailyRVO) {
		return this.dailyReportMapper.checkReport(dailyRVO);
	}

	@Override
	public DailyReportVO getReportDetail(DailyReportVO dailyReportVO) {
		return this.dailyReportMapper.getReportDetail(dailyReportVO);
	}

	@Override
	public DailyReportVO getCreateReportNo(DailyReportVO dailyRVO) {
		return this.dailyReportMapper.getCreateReportNo(dailyRVO);
	}

	@Override
	public int getEmpReportTotal(Map<String, String> map) {
		return this.dailyReportMapper.getEmpReportTotal(map);
	}

	@Override
	public int getDeptReportTotal(Map<String, String> map) {
		return this.dailyReportMapper.getDeptReportTotal(map);
	}

	@Override
	public int getDeptReportTotalAdmin(Map<String, String> map) {
		return this.dailyReportMapper.getDeptReportTotalAdmin(map);
	}

	@Override
	public int getDeptMemCount(String empNo) {
		return this.dailyReportMapper.getDeptMemCount(empNo);
	}

	@Override
	public List<DailyReportVO> getDeptMemList(String empNo) {
		return this.dailyReportMapper.getDeptMemList(empNo);
	}

	@Override
	public int getDeptMemListCount(String empNo) {
		return this.dailyReportMapper.getDeptMemListCount(empNo);
	}

	@Override
	public int nonChkReportCount(String empNo) {
		return this.dailyReportMapper.nonChkReportCount(empNo);
	}

	@Override
	public int confirmReport(DailyReportVO dailyRVO) {
		return this.dailyReportMapper.confirmReport(dailyRVO);
	}

	@Override
	public int todayChkReportCount(String rptpCmptnPic) {
		return this.dailyReportMapper.todayChkReportCount(rptpCmptnPic);
	}

	@Override
	public List<DailyReportVO> getWeekReport(String empNo) {
		return this.dailyReportMapper.getWeekReport(empNo);
	}

	@Override
	public DailyReportVO deptReportChart(String empNo) {
		return this.dailyReportMapper.deptReportChart(empNo);
	}

	@Override
	public List<Map<String, String>> deptReportDepDayChart(String empNo) {
		return this.dailyReportMapper.deptReportDepDayChart(empNo);
	}

	@Override
	public List<Map<String, String>> deptReportDepWeekChart(String empNo) {
		return this.dailyReportMapper.deptReportDepWeekChart(empNo);
	}

	@Override
	public List<Map<String, String>> deptReportDepMonthChart(String empNo) {
		return this.dailyReportMapper.deptReportDepMonthChart(empNo);
	}
}

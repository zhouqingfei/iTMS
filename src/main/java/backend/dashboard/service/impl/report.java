package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.ReportLogBiz;
import backend.dashboard.test.dao.ReportLogDao;
import backend.entity.ReportLog;

@Service
public class report implements ReportLogBiz {

	 
	 @Resource
	    private ReportLogDao reportLogDao;
	@Override
	public void add(ReportLog reportlog) {
		// TODO Auto-generated method stub
		reportLogDao.add(reportlog);
	}

	@Override
	public List<ReportLog> findAll() {
		
		return reportLogDao.findAll();
	}

	@Override
	public ReportLog findTestCaseById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(int logId) {
		// TODO Auto-generated method stub
		reportLogDao.delete(logId);
	}

	@Override
	public List<ReportLog> findAllTester(String loginId) {
		// TODO Auto-generated method stub
		return reportLogDao.findAllTester(loginId);
		
	}

	@Override
	public List<ReportLog> search(String content) {
		// TODO Auto-generated method stub
		return reportLogDao.search("%"+content+"%");
	}

}

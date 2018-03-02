package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.TestReportBiz;
import backend.dashboard.test.dao.TestReportDao;
import backend.entity.TestReport;

@Service
public class TestReportBizImpl implements TestReportBiz {

	 @Resource
	    private TestReportDao testReportDao;
	@Override
	public List<TestReport> findAll() {
		// TODO Auto-generated method stub
		return testReportDao.findAll();
	}

	@Override
	public TestReport findTestCaseById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void add(TestReport testReport) {
		// TODO Auto-generated method stub
		testReportDao.add(testReport);
	}

	@Override
	public void delete(int reportId) {
		// TODO Auto-generated method stub
		testReportDao.delete(reportId);
	}

	@Override
	public List<TestReport> findAllTester(String loginId) {
		// TODO Auto-generated method stub
		return testReportDao.findAllTester(loginId);
	}

	@Override
	public List<TestReport> search(String content) {
		// TODO Auto-generated method stub
		return testReportDao.search("%"+content+"%");
	}

	@Override
	public TestReport findRecentReport(String reportNumber) {
		// TODO Auto-generated method stub
		return testReportDao.findRecentReport(reportNumber);
	}

	

}

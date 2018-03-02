package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ReportLog;
import backend.entity.TestReport;

public interface TestReportDao {
	public List<TestReport> findAll();
	public List<TestReport> search(String content);
    //public void add(String deptName);
	public TestReport findRecentReport(String reportNumber);
    public ReportLog findTestCaseById(int id);
	public void add(TestReport testReport);
	public void delete(int reportId);
	public List<TestReport> findAllTester(String loginId);
}

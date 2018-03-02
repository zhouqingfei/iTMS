package backend.dashboard.service;

import java.util.List;

import backend.entity.TestReport;

public interface TestReportBiz {

	public List<TestReport> findAll();
	public List<TestReport> search(String content);
    //public void add(String deptName);
    public TestReport findTestCaseById(int id);
    public TestReport findRecentReport(String reportNumber);
	public void add(TestReport testReport);
	public void delete(int reportId);
	public List<TestReport> findAllTester(String loginId);
}

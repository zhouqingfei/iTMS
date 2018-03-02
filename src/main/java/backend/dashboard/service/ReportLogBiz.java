package backend.dashboard.service;

import java.util.List;

import backend.entity.ReportLog;

public interface ReportLogBiz {

	public List<ReportLog> findAll();
	public List<ReportLog> search(String content);
    //public void add(String deptName);
    public ReportLog findTestCaseById(int id);
	public void add(ReportLog reportLog);
	public void delete(int logId);
	public List<ReportLog> findAllTester(String loginId);
}

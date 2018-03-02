package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ReportLog;



public interface ReportLogDao {
	public List<ReportLog> findAll();
	public List<ReportLog> search(String content);
    //public void add(String deptName);
    public ReportLog findTestCaseById(int id);
	public void add(ReportLog reportLog);
	public void delete(int logId);
	public List<ReportLog> findAllTester(String loginId);
}

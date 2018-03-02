package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.TestTask;

public interface TestTaskDao {
	public List<TestTask> findAll(String loginId);
    //public void add(String deptName);
    public TestTask findTestTaskById(int id);
	public void add(TestTask testTask);
	public void delete(int id);
	public void update(TestTask testTask);
	public List<TestTask> search(String content); 
	
	public int getPassCount(String loginId);
	public int getFailCount(String loginId);
	public int getTbdCount(String loginId);
	
	public int getFinishedCount(String loginId);
	public int getRunningCount(String loginId);
	public int getReadyCount(String loginId);
	public int getStopCount(String loginId);
}

package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.TestCase;

public interface TestCaseDao {
	public List<TestCase> findAll();
    //public void add(String deptName);
	public List<TestCase> search(String content); 
    public TestCase findTestCaseById(int id);
	public void add(TestCase testcase);
	public void delete(int id);
	public void update(TestCase testcase);
}

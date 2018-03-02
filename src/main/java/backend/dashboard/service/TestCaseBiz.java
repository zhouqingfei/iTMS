package backend.dashboard.service;

import java.util.List;

import backend.entity.TestCase;

public interface TestCaseBiz {
	public List<TestCase> findAll();   
	public List<TestCase> search(String content);   
    public TestCase findTestCaseById(int id);
	public void add(TestCase testcase);
	public void delete(int id);
	public void update(TestCase testcase);
}

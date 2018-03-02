package backend.dashboard.service;

import java.util.List;

import backend.entity.TestSuit;


public interface TestSuitBiz {
	public List<TestSuit> findAll();  
	public List<TestSuit> search(String content);
    public TestSuit findTestSuitById(int id);
	public void add(TestSuit testSuit);
	public void delete(int id);
	public void update(TestSuit testsuit);
}

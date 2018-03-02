package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.TestCase;
import backend.entity.TestSuit;

public interface TestSuitDao {
	public List<TestSuit> findAll();
    //public void add(String deptName);
	public List<TestSuit> search(String content);
    public TestSuit findSuitById(int id);
	public void add(TestSuit testsuit);
	public void delete(int id);
	public void update(TestSuit testsuit);
}

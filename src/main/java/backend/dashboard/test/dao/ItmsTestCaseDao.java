package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ItmsTestCase;

public interface ItmsTestCaseDao {

	public void add(ItmsTestCase itmsTestCase);

	public List<ItmsTestCase> findAll();

	public List<ItmsTestCase> findByPagination(int from ,int count);
	
	public void updateScriptInfo(ItmsTestCase itmsTestCase);
	
	public ItmsTestCase findById(int id);
}

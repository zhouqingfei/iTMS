package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ItmsTestCaseTree;


public interface ItmsTestCaseTreeDao {
	
	public List<ItmsTestCaseTree> getChildrenByPid(String id);
	
	public ItmsTestCaseTree getRoot();
	
	public void save(ItmsTestCaseTree itmsTestCaseTree);
	
	public List<ItmsTestCaseTree> findAll();
	
	public void update(ItmsTestCaseTree itmsTestCaseTree);
	
	public void delete(int id);
	
	public void deleteByParentId(int parentId);
}

package backend.dashboard.service;

import java.util.List;

import backend.entity.ItmsTestCaseTree;

public interface ItmsTestCaseTreeBiz {
	
	public List<ItmsTestCaseTree> getChildrenByPid(String id);
	
	public ItmsTestCaseTree getRoot();
	
	public void save(ItmsTestCaseTree itmsTestCaseTree);
	
	public List<ItmsTestCaseTree> findAll();
	
	public void update(ItmsTestCaseTree itmsTestCaseTree);
	
	public void delete(int id);
}

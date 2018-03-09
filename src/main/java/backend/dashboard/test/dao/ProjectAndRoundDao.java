package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ProjectAndRound;
import backend.entity.TestCase;

public interface ProjectAndRoundDao {
	public List<ProjectAndRound> getChildrenByPid(String id);
	
	public ProjectAndRound getRoot();
	
	public void save(ProjectAndRound projectAndRound);
	
	public List<ProjectAndRound> findAll();
	
	public void update(ProjectAndRound projectAndRound);
	
	public void delete(int id);
	
	public void deleteByParentId(int parentId);
	
	public ProjectAndRound findById(int id);
}

package backend.dashboard.service;

import java.util.List;

import backend.entity.ProjectAndRound;

public interface ProjectAndRoundBiz {
	public List<ProjectAndRound> getChildrenByPid(String id);
	public ProjectAndRound getRoot();
	public void save(ProjectAndRound projecrAndRound);
	public List<ProjectAndRound> findAll();
	
	public void update(ProjectAndRound projectAndRound);
	
	public void delete(int id);
}

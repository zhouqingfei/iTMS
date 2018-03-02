package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.ProjectAndRoundBiz;
import backend.dashboard.test.dao.ProjectAndRoundDao;
import backend.entity.ProjectAndRound;

@Service
public class ProjectAndRoundBizImpl implements ProjectAndRoundBiz {

	@Resource
	private ProjectAndRoundDao projectAndRoundDao;
	
	@Override
	public List<ProjectAndRound> getChildrenByPid(String id) {
		return projectAndRoundDao.getChildrenByPid(id);
	}

	@Override
	public ProjectAndRound getRoot() {
		return projectAndRoundDao.getRoot();
	}

	@Override
	public void save(ProjectAndRound projecrAndRound) {
		projectAndRoundDao.save(projecrAndRound);
	}

	@Override
	public List<ProjectAndRound> findAll() {
		// TODO 自动生成的方法存根
		return projectAndRoundDao.findAll();
	}

	@Override
	public void update(ProjectAndRound projectAndRound) {
		// TODO 自动生成的方法存根
		projectAndRoundDao.update(projectAndRound);
	}

	@Override
	public void delete(int id) {
		// TODO 自动生成的方法存根
		projectAndRoundDao.deleteByParentId(id);
		projectAndRoundDao.delete(id);
	}
	
}
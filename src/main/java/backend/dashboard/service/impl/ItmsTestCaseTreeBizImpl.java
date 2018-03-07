package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.ItmsTestCaseTreeBiz;
import backend.dashboard.test.dao.ItmsTestCaseTreeDao;
import backend.entity.ItmsTestCaseTree;

@Service
public class ItmsTestCaseTreeBizImpl implements ItmsTestCaseTreeBiz{

	@Resource
	private ItmsTestCaseTreeDao itmsTestCaseTreeDao;
	
	@Override
	public List<ItmsTestCaseTree> getChildrenByPid(String id) {
		return itmsTestCaseTreeDao.getChildrenByPid(id);
	}

	@Override
	public ItmsTestCaseTree getRoot() {
		return itmsTestCaseTreeDao.getRoot();
	}

	@Override
	public void save(ItmsTestCaseTree itmsTestCaseTree) {
		itmsTestCaseTreeDao.save(itmsTestCaseTree);
	}

	@Override
	public List<ItmsTestCaseTree> findAll() {
		return itmsTestCaseTreeDao.findAll();
	}

	@Override
	public void update(ItmsTestCaseTree itmsTestCaseTree) {
		itmsTestCaseTreeDao.update(itmsTestCaseTree);
	}

	@Override
	public void delete(int id) {
		itmsTestCaseTreeDao.deleteByParentId(id);
		itmsTestCaseTreeDao.delete(id);
	}
	
}

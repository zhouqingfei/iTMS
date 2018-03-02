package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.TestSuitBiz;
import backend.dashboard.test.dao.TestSuitDao;
import backend.entity.TestSuit;

@Service
public class TestSuitBizImpl implements TestSuitBiz {

	@Resource
	private TestSuitDao testSuitDao;

	@Override
	public List<TestSuit> findAll() {
		// TODO Auto-generated method stub
		return testSuitDao.findAll();
	}

	@Override
	public TestSuit findTestSuitById(int id) {
		// TODO Auto-generated method stub
		return testSuitDao.findSuitById(id);
	}

	@Override
	public void add(TestSuit testSuit) {
		// TODO Auto-generated method stub
		testSuitDao.add(testSuit);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		testSuitDao.delete(id);
	}

	@Override
	public void update(TestSuit testsuit) {
		// TODO Auto-generated method stub
		testSuitDao.update(testsuit);
	}

	@Override
	public List<TestSuit> search(String content) {
		// TODO Auto-generated method stub
		return testSuitDao.search("%"+content+"%");
	}

}

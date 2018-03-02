package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.TestCaseBiz;
import backend.dashboard.test.dao.TestCaseDao;
import backend.entity.TestCase;

@Service
public class TestCaseBizImpl implements TestCaseBiz {

	 @Resource
	    private TestCaseDao testCaseDao;
	public List<TestCase> findAll() {
		// TODO Auto-generated method stub
		return testCaseDao.findAll();
	}

	
	public TestCase findTestCaseById(int id) {
		// TODO Auto-generated method stub
		return testCaseDao.findTestCaseById(id);
	}


	@Override
	public void add(TestCase testcase) {
		// TODO Auto-generated method stub
		 testCaseDao.add(testcase);
	}


	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		testCaseDao.delete(id);
	}


	@Override
	public void update(TestCase testcase) {
		// TODO Auto-generated method stub
		testCaseDao.update(testcase);
	}


	@Override
	public List<TestCase> search(String content) {
		// TODO Auto-generated method stub
		return testCaseDao.search("%"+content+"%");
	}

}

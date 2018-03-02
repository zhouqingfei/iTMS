package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.TestTaskBiz;
import backend.dashboard.test.dao.TestTaskDao;
import backend.entity.TestTask;

@Service
public class TestTaskBizImpl implements TestTaskBiz{
	@Resource
    private TestTaskDao testTaskDao;

	@Override
	public List<TestTask> findAll(String loginId) {
		// TODO Auto-generated method stub
		
		return testTaskDao.findAll(loginId);
	}

	@Override
	public TestTask findTestTaskById(int id) {
		// TODO Auto-generated method stub
		return testTaskDao.findTestTaskById(id);
	}

	@Override
	public void add(TestTask testTask) {
		// TODO Auto-generated method stub
		testTaskDao.add(testTask);
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		testTaskDao.delete(id);
	}

	@Override
	public void update(TestTask testTask) {
		// TODO Auto-generated method stub
		testTaskDao.update(testTask);
	}
	@Override
	public int getPassCount(String loginId) {
		// TODO Auto-generated method stub
		return testTaskDao.getPassCount(loginId);
	}
	
	@Override
	public int getFailCount(String loginId) {
		// TODO Auto-generated method stub
		return testTaskDao.getFailCount(loginId);
	}
	
	@Override
	public int getTbdCount(String loginId) {
		// TODO Auto-generated method stub
		return testTaskDao.getTbdCount(loginId);
	}
	
	@Override
	public int getFinishedCount(String loginId) {
		// TODO Auto-generated method stub
		System.out.print("!!!!!!!!!!!!!!!!!!!!!");
		return testTaskDao.getFinishedCount(loginId);
	}
	
	@Override
	public int getRunningCount(String loginId) {
		// TODO Auto-generated method stub
		return testTaskDao.getRunningCount(loginId);
	}
	
	@Override
	public int getReadyCount(String loginId) {
		// TODO Auto-generated method stub
		return testTaskDao.getReadyCount(loginId);
	}
	
	@Override
	public int getStopCount(String loginId) {
		// TODO Auto-generated method stub
		return testTaskDao.getStopCount(loginId);
	}

	@Override
	public List<TestTask> search(String content) {
		// TODO Auto-generated method stub
		return testTaskDao.search("%"+content+"%");
	}
}

package backend.dashboard.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import backend.dashboard.service.UserTmpBiz;
import backend.dashboard.test.dao.ReportLogDao;
import backend.dashboard.test.dao.UserTmpDao;
import backend.entity.User;

@Service
public class UserTmpBizImpl implements UserTmpBiz {
	 @Resource
	    private UserTmpDao userTmpDao;
	
	@Override
	public void add(User user) {
		// TODO Auto-generated method stub

		userTmpDao.add(user);
	}

	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		return userTmpDao.findAll();
	}

	
	@Override
	public void delete(String userId) {
		// TODO Auto-generated method stub
		userTmpDao.delete(userId);
	}

	@Override
	public User findById(String userId) {
		return userTmpDao.findById(userId);
	}

	
}

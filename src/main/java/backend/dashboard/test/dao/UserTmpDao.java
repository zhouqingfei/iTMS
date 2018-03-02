package backend.dashboard.test.dao;

import java.util.List;

import backend.entity.ReportLog;
import backend.entity.TestTask;
import backend.entity.User;

public interface UserTmpDao {
	public void add(User user);
	public List<User> findAll();
	
	public void delete(String userId);
	public User findById(String userId);
}

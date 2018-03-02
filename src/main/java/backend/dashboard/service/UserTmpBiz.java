package backend.dashboard.service;

import java.util.List;

import backend.entity.User;

public interface UserTmpBiz {
	public List<User> findAll();   
	public void add(User user);
	public void delete(String userId);
	public User findById(String userId);
}

package backend.system.service;


import backend.entity.TestCase;
import backend.entity.User;
import backend.entity.custom.UserVo;

import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Set;


public interface UserBiz {
    public List<UserVo> findAll() throws InvocationTargetException, IllegalAccessException;

    public User findById(String id);

    public void update(User user);

    public void add(User user);

    public void delete(String id);

    public void changePassword(String userId, String newPassword);


    public User findByUsername(String username);

    public Set<String> findRoles(String username);

    public Set<String> findPermissions(String username);

    public List<User> findAllUser(String leader);   

	public void updateLeader(User user);

	public void deleteNumber(String userId);

	
}

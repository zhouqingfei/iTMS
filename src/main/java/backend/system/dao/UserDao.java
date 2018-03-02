package backend.system.dao;

import org.apache.ibatis.annotations.Param;

import backend.entity.User;

import java.util.List;


public interface UserDao {
    public List<User> findAll();

    public User findById(String id);

    public void update(User user);

    public void add(User user);

    public void delete(String id);

    public User findByIdAndPassword(@Param("id") String username, @Param("password") String password);

    public void updatePassword(@Param("userId") String id, @Param("password") String password);

    User findByUsername(String username);

	public void updateLeader(User user);

	

	public List<User> findAllUser(String leader);

	public void deleteNumber(String userId);

	public void updatePas(User user);
}

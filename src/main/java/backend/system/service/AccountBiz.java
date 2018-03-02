package backend.system.service;

import backend.entity.User;

public interface AccountBiz {

    public User findByIdAndPassword(String username, String password);

    public void updatePassword(String id, String password);
}

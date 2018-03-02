package backend.system.service.impl;

import backend.entity.User;
import backend.system.dao.UserDao;
import backend.system.service.AccountBiz;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service
public class AccountBizImpl implements AccountBiz {

    @Resource
    UserDao userDao;

    @Override
    public User findByIdAndPassword(String username, String password) {
        return userDao.findByIdAndPassword(username, password);
    }


    @Override
    public void updatePassword(String id, String password) {
        userDao.updatePassword(id, password);
    }
}

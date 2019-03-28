package com.neuedu.service.user;

import com.neuedu.pojo.User;

import java.util.List;

/**
 * Created by Administrator on 2019/3/27.
 */
public interface UserService {
    User login(User user);
    List<User> list(User user);
}

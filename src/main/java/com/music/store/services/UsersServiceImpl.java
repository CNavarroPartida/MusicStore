package com.music.store.services;

import java.util.List;

import com.music.store.interfaces.UsersDAO;
import com.music.store.interfaces.UsersService;
import com.music.store.models.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsersServiceImpl implements UsersService {
    @Autowired
    private UsersDAO usersDao;

    public List<Users> getAllUsers() {
        return this.usersDao.getAllUsers();
    }

    public Users getUserById(int id) {
        return this.usersDao.getUserById(id);
    }

    public void addUser(Users user) {
        this.usersDao.addUser(user);
    }

    public void updateUser(Users user) {
        this.usersDao.updateUser(user);
    }

    public void deleteUser(int id) {
        this.usersDao.deleteUser(id);
    }

    public String loginValidation(String username, String password) {
        return usersDao.loginValidation(username, password);
    }
}
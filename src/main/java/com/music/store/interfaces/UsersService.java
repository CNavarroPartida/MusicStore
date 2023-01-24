package com.music.store.interfaces;

import com.music.store.models.Users;

import java.util.List;

public interface UsersService {
    List<Users> getAllUsers();
    Users getUserById(int id);
    void addUser(Users user);
    void updateUser(Users user);
    void deleteUser(int id);

    String loginValidation(String username, String password);
}

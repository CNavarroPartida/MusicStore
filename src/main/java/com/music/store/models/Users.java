package com.music.store.models;

import lombok.Data;

@Data
public class Users {
    private int id;
    private String username;
    private String password;
    private String role;
}

package com.music.store.actions;

import com.music.store.enums.UniqueCode;
import com.music.store.interfaces.UsersService;
import com.music.store.models.Users;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Data
@Component
public class LoginAction extends ActionSupport implements SessionAware {
    public static final String VACIO = "";
    private static final String SUCCESS_ADMIN = "success_admin";
    private static final String SUCCESS_COMMON = "success_common";
    private String username;
    private String password;

    private boolean logged = false;
    private Map<String, Object> session;

    @Autowired
    private UsersService usersService;

    public String execute() {
        // Validar las credenciales del usuario
        String credentials = validateCredentials(username, password);
        if (!credentials.equals(VACIO)) {
            UniqueCode uniqueCode = UniqueCode.valueOf(credentials);

            if (uniqueCode == UniqueCode.VALID_USER) {
                System.out.println("User is valid");
                return SUCCESS_COMMON;
            } else if (uniqueCode.equals(UniqueCode.ADMIN_USER)) {
                System.out.println("User is an admin");
                return SUCCESS_ADMIN;
            } else {
                addActionError("Invalid username or password.");
                return INPUT;
            }

        } else {
            addActionError("Invalid username or password.");
            return INPUT;
        }
    }

    private String validateCredentials(String username, String password) {
        if (username != null && password != null) {
            return usersService.loginValidation(username, password);
        }
        return VACIO;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}

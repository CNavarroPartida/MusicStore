package com.music.store.actions;

import com.music.store.interfaces.SongsService;
import com.music.store.models.Songs;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Data
@Component
public class HomeAdminAction extends ActionSupport {

    private String title;
    private String artist;
    private String album;
    private String genre;
    private Double price;
    private Integer aviable_quantity;

    public String execute() {
        // Perform logic to add song here
        System.out.println("Exercutaro");
        return INPUT;
    }
}

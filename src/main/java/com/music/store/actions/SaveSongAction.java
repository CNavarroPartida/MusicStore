package com.music.store.actions;

import com.music.store.actions.data.SongsDataProvider;
import com.music.store.interfaces.SongsService;
import com.music.store.models.Songs;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Data
@Component
public class SaveSongAction extends ActionSupport {

    private Songs song;

    @Autowired
    private SongsService songsService;
    private String result = "input";

    public String execute() {
        if(song.getTitle().equals("")) {
            return INPUT;
        } else{
            String serviceResult = songsService.addSong(this.song);
            if(serviceResult.equals("SUCCESS")) {
                result = "success";
                return SUCCESS;
            } else if(serviceResult.equals("DUPLICATE_TITLE")){
                addActionError("Canción duplicada");
                result = "duplicate_title";
                return "duplicate_title";
            } else {
                addActionError("Ocurrio un error al guardar la canción");
                result = "error";
                return ERROR;
            }
        }

    }
}
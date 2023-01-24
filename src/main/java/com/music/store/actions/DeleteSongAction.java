package com.music.store.actions;

import com.music.store.interfaces.SongsService;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Data
@Component
public class DeleteSongAction extends ActionSupport {
    private int id;

    @Autowired
    private SongsService songsService;
    private String result = "input";

    public String execute() {
        if (id == 0) {
            return INPUT;
        } else {
            String resutl = songsService.deleteSong(id);
            if (resutl.equals("SUCCESS")) {
                return SUCCESS;
            } else if (resutl.equals("SONG_NOT_FOUND")) {
                addActionError("Cancion no encontrada");
                result = "cancion no encontrada";
                return "song_not_found";
            } else {
                return INPUT;
            }
        }
    }
}

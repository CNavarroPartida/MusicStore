package com.music.store.services;

import com.music.store.interfaces.SongsDAO;
import com.music.store.interfaces.SongsService;
import com.music.store.models.Songs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SongsServiceImpl implements SongsService {

    @Autowired
    private SongsDAO songsDAO;

    public List<Songs> getAllSongs() {
        return this.songsDAO.getAllSongs();
    }
    public Songs getSongById(int id) {
        return this.songsDAO.getSongById(id);
    }
    public String addSong(Songs song){
        return this.songsDAO.addSong(song);
    }
    public void updateSong(Songs song){
        this.songsDAO.updateSong(song);
    }
    public String deleteSong(int id){
        return this.songsDAO.deleteSong(id);
    }

    public List<Songs> getSongs(int from, int to){
        return this.songsDAO.getSongs(from, to);
    }

    public Integer getSongsCount(){
        return this.songsDAO.getSongsCount();
    }


}

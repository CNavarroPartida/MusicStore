package com.music.store.interfaces;

import com.music.store.models.Songs;

import java.util.List;

public interface SongsDAO {
    List<Songs> getAllSongs();
    Songs getSongById(int id);
    String addSong(Songs song);
    void updateSong(Songs song);
    String deleteSong(int id);

    List<Songs> getSongs(int from, int to);

    Integer getSongsCount();

}

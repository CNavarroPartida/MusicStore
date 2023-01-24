package com.music.store.daos;

import com.music.store.interfaces.SongsDAO;
import com.music.store.models.Songs;
import com.music.store.models.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Repository
public class SongsDAOImpl implements SongsDAO {
    private JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall simpleJdbcCall;
    private SimpleJdbcCall simpleJdbcCallDelete;

    private static List<Songs> songs = new LinkedList<Songs>();

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("sp_song_creation")
                .declareParameters(
                        new SqlParameter("input_title", Types.VARCHAR),
                        new SqlParameter("input_artist", Types.VARCHAR),
                        new SqlParameter("input_album", Types.VARCHAR),
                        new SqlParameter("input_genre", Types.VARCHAR),
                        new SqlParameter("input_price", Types.DECIMAL),
                        new SqlParameter("input_available_quantity", Types.INTEGER),
                        new SqlOutParameter("unique_code", Types.VARCHAR)
                );
        this.simpleJdbcCallDelete = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("sp_song_delete_by_id")
                .declareParameters(
                        new SqlParameter("input_id", Types.INTEGER),
                        new SqlOutParameter("unique_code", Types.VARCHAR)
                );
    }

    public List<Songs> getAllSongs() {
        return this.jdbcTemplate.query("SELECT * FROM songs", new SongsDAOImpl.SongMapper());
    }

    public Songs getSongById(int id) {
        return this.jdbcTemplate.queryForObject("SELECT * FROM songs WHERE id = ?", new Object[]{id}, new SongsDAOImpl.SongMapper());
    }

    public String addSong(Songs song) {
        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("input_title", song.getTitle())
                .addValue("input_artist", song.getArtist())
                .addValue("input_album", song.getAlbum())
                .addValue("input_genre", song.getGenre())
                .addValue("input_price", song.getPrice())
                .addValue("input_available_quantity", song.getAvailableQuantity());
        Map<String, Object> out = simpleJdbcCall.execute(in);
        return (String) out.get("unique_code");
    }

    public void updateSong(Songs song) {
        this.jdbcTemplate.update("UPDATE songs SET available_quantity = ? WHERE id = ?", song.getAvailableQuantity(), song.getId());
    }

    public String deleteSong(int id) {
        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("input_id", id);
        Map<String, Object> out = simpleJdbcCallDelete.execute(in);
        return (String) out.get("unique_code");
    }

    public List<Songs> getSongs(int from, int to){
        if(songs.isEmpty()){
            songs = this.getAllSongs();
        }

        return songs.subList(from, to);
    }

    public Integer getSongsCount(){
        return songs.size();
    }

    private static final class SongMapper implements RowMapper<Songs> {
        public Songs mapRow(ResultSet rs, int rowNum) throws SQLException {
            Songs song = new Songs();
            song.setId(rs.getInt("id"));
            song.setTitle(rs.getString("title"));
            song.setArtist(rs.getString("artist"));
            song.setAlbum(rs.getString("album"));
            song.setGenre(rs.getString("genre"));
            song.setPrice(rs.getBigDecimal("price"));
            song.setAvailableQuantity(rs.getInt("available_quantity"));
            return song;
        }
    }
}

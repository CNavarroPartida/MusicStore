package com.music.store.daos;

import com.music.store.interfaces.UsersDAO;
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
import java.util.List;
import java.util.Map;

@Repository
public class UsersDAOImpl implements UsersDAO {
    private JdbcTemplate jdbcTemplate;
    private SimpleJdbcCall simpleJdbcCall;

    @Autowired
    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.simpleJdbcCall = new SimpleJdbcCall(jdbcTemplate)
                .withProcedureName("sp_user_login_validation")
                .declareParameters(
                        new SqlParameter("input_username_email", Types.VARCHAR),
                        new SqlParameter("input_password", Types.VARCHAR),
                        new SqlOutParameter("unique_code", Types.VARCHAR)
                );
    }

    public List<Users> getAllUsers() {
        return this.jdbcTemplate.query("SELECT * FROM users", new UserMapper());
    }

    public Users getUserById(int id) {
        return this.jdbcTemplate.queryForObject("SELECT * FROM users WHERE id = ?", new Object[] {id}, new UserMapper());
    }

    public void addUser(Users user) {
        this.jdbcTemplate.update("INSERT INTO users (username, password, role) VALUES (?, ?, ?)", user.getUsername(), user.getPassword(), user.getRole());
    }

    public void updateUser(Users user) {
        this.jdbcTemplate.update("UPDATE users SET username = ?, password = ?, role = ? WHERE id = ?", user.getUsername(), user.getPassword(), user.getRole(), user.getId());
    }

    public void deleteUser(int id) {
        this.jdbcTemplate.update("DELETE FROM users WHERE id = ?", id);
    }

    public String loginValidation(String username, String password) {
        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("input_username_email", username)
                .addValue("input_password", password);
        Map<String, Object> out = simpleJdbcCall.execute(in);
        return (String) out.get("unique_code");
    }

    private static final class UserMapper implements RowMapper<Users> {
        public Users mapRow(ResultSet rs, int rowNum) throws SQLException {
            Users user = new Users();
            user.setId(rs.getInt("id"));
            user.setUsername(rs.getString("username"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
            return user;
        }
    }
}
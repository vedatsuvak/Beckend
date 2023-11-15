package com.gms.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.gms.model.User;

public class UsersDAO {
	private JdbcTemplate temp;
	public void setTemp(JdbcTemplate temp) {
	    this.temp = temp;
	}

	//DONE
	// Insert a new user
	public int insertUser(String username, String password, String email) throws ClassNotFoundException, SQLException {	    
	    String sql = "INSERT INTO users values('"+username+"', '"+password+"', '"+email+"')";
	    System.out.println("[DB] User registered");
	    return temp.update(sql);
	}

	//DONE
	// Retrieve users as admin
	public List<User> displayUsers() throws ClassNotFoundException, SQLException {
	        String sql = "SELECT * FROM users ORDER BY username";
	        return temp.query(sql,new ResultSetExtractor<List<User>>() {
				public List<User> extractData(ResultSet rs) throws SQLException, DataAccessException {
					ArrayList<User> allUsers=new ArrayList<User>();
					while(rs.next()) {
						User user=new User();
						user.setUsername(rs.getString(1));
						user.setPassword(rs.getString(2));
						user.setEmail(rs.getString(3));
						allUsers.add(user);
					}
					System.out.println("[DB] All Users displayed");
					return allUsers;
				}
			});
		}

	//DONE
	// Retrieve as user
	public User displayUser(String username) throws ClassNotFoundException, SQLException {
			ApplicationContext ac=new ClassPathXmlApplicationContext("zumba.xml");
	        String sql = "SELECT * FROM users WHERE username ='"+username+"'";
	        User user = ac.getBean(User.class);
	        return temp.query(sql, new ResultSetExtractor<User>() {
		        public User extractData(ResultSet rs) throws SQLException, DataAccessException {
		            if (rs.next()) { 
		            	user.setUsername(rs.getString(1));
		            	user.setPassword(rs.getString(2));
		            	user.setEmail(rs.getString(3));
		            	System.out.println("[DB] User displayed");
		            	return user;
		            }else {
		            System.out.println("[DB] User not found");
		            }
		            return user;
		        }
		    });
		}

	//DONE
	//update 
	public int editUser(String oldUserName, String newUserName, String newPassword, String newEmail) throws ClassNotFoundException, SQLException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
	    String sql = "UPDATE users SET username ='"+newUserName+"', password ='"+newPassword+"', email ='"+newEmail+"' WHERE username ='"+oldUserName+"'";
	    int result = 0;
	    result = temp.update(sql) + pdao.updateParticipant(oldUserName, newUserName, newEmail);
	    if(result > 0) {
	    	System.out.println("[DB] User edited");
	    }else {
	    	System.out.println("[DB] User not edited");
	    }
	    return result;
	}
	
	//DONE
	//delete
	public int deleteUser(String selectedUsername) throws ClassNotFoundException, SQLException {
	       String sql = "DELETE FROM users WHERE username ='"+selectedUsername+"'";
	       ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
	       ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
	       int result = 0;
	       result = temp.update(sql) + pdao.deleteParticipant(selectedUsername);
	       if(result > 0) {
	    	   System.out.println("[DB] User deleted");
	       }else {
	    	   System.out.println("[DB] User delete failed");
	       }
	       return result;
	}
	
	//DONE
	// Login 
	public User login(String username, String password) throws ClassNotFoundException, SQLException {
			ApplicationContext ac=new ClassPathXmlApplicationContext("zumba.xml");
	        String sql = "SELECT * FROM users WHERE username ='"+username+"' AND password ='"+password+"'";
	        User user = ac.getBean(User.class);
	        return temp.query(sql, new ResultSetExtractor<User>() {
		        public User extractData(ResultSet rs) throws SQLException, DataAccessException {
		            if (rs.next()) { 
		            	user.setUsername(rs.getString(1));
		            	user.setPassword(rs.getString(2));
		            	user.setEmail(rs.getString(3));
		            	System.out.println("[DB] User logged in");
		            	return user;
		            }
		            System.out.println("[DB] User not found");
		            return user;
		        }
		    });
		}
}
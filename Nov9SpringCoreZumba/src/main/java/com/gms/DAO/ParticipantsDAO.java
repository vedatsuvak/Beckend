
package com.gms.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.gms.model.Batch;
import com.gms.model.Participants;
import com.gms.model.User;

public class ParticipantsDAO {
	private JdbcTemplate temp;
	public void setTemp(JdbcTemplate temp) {
	    this.temp = temp;
	}

	//DONE
    // Insert
    public int insertParticipant(Participants participant) throws ClassNotFoundException, SQLException {
    	String sql = "INSERT INTO participants VALUES ('0', '"+participant.getPname().toUpperCase()+"', '"+participant.getAge()+"', '"+participant.getGender()+"', '"+participant.getPhone()+"', '"+participant.getEmail()+"', '"+participant.getBid()+"')";
    	System.out.println("[DB] Participant added to Batch" + participant.getBid());
    	return temp.update(sql);
    }
    
    //DONE
    // Retrieve all participants
    public List<Participants> displayParticipants() throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM participants ORDER BY bid";
        return temp.query(sql, new ResultSetExtractor<List<Participants>>() {
			public List<Participants> extractData(ResultSet rs) throws SQLException, DataAccessException {
				ArrayList<Participants> participants = new ArrayList<Participants>();
				while(rs.next()) {
					Participants participant = new Participants();
					participant.setPid(rs.getInt(1));
	            	participant.setPname(rs.getString(2));
	            	participant.setAge(rs.getInt(3));
	            	participant.setGender(rs.getString(4));
	            	participant.setPhone(rs.getString(5));
	            	participant.setEmail(rs.getString(6));
	            	participant.setBid(rs.getInt(7));
	            	participants.add(participant);
				}
				System.out.println("[DB] All Participats listed");
				return participants;
			}
		});
    }
    
    //DONE
    // Retrieve Specific Batch's participants
    public List<Participants> BatchParticipants(int bid) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM participants WHERE bid =" + bid + "";
        return temp.query(sql, new ResultSetExtractor<List<Participants>>() {
				public List<Participants> extractData(ResultSet rs) throws SQLException, DataAccessException {
					ArrayList<Participants> participants = new ArrayList<Participants>();
					while(rs.next()) {
						Participants participant = new Participants();
						participant.setPid(rs.getInt(1));
		            	participant.setPname(rs.getString(2));
		            	participant.setAge(rs.getInt(3));
		            	participant.setGender(rs.getString(4));
		            	participant.setPhone(rs.getString(5));
		            	participant.setEmail(rs.getString(6));
		            	participant.setBid(rs.getInt(7));
		            	participants.add(participant);
					}
					System.out.println("[DB] Participats for Batch: " + bid + " listed");
					return participants;
				}
			});
	}
           
    //DONE
    //Override Retrieve Specific Participant's Batches
    public List<Participants> BatchParticipants(String username) throws ClassNotFoundException, SQLException {
        String sql = "SELECT * FROM participants WHERE pname ='"+username+"' ORDER BY bid";
        return temp.query(sql, new ResultSetExtractor<List<Participants>>() {
			public List<Participants> extractData(ResultSet rs) throws SQLException, DataAccessException {
				ArrayList<Participants> participants = new ArrayList<Participants>();
				while(rs.next()) {
					Participants participant = new Participants();
					participant.setPid(rs.getInt(1));
	            	participant.setPname(rs.getString(2));
	            	participant.setAge(rs.getInt(3));
	            	participant.setGender(rs.getString(4));
	            	participant.setPhone(rs.getString(5));
	            	participant.setEmail(rs.getString(6));
	            	participant.setBid(rs.getInt(7));
	            	participants.add(participant);
				}
				System.out.println("[DB] Batches for " + username.toUpperCase() + " listed");
				return participants;
			}
		});
    }
    
    //DONE
    // Retrieve a specific participant
    public Participants getParticipant(int pid) throws ClassNotFoundException, SQLException {
		ApplicationContext ac=new ClassPathXmlApplicationContext("zumba.xml");
		String sql = "SELECT * FROM participants WHERE pid ="+pid+"";
		Participants participant = ac.getBean(Participants.class);
        return temp.query(sql, new ResultSetExtractor<Participants>() {
	        public Participants extractData(ResultSet rs) throws SQLException, DataAccessException {
	            if (rs.next()) { 
	            	participant.setPid(rs.getInt(1));
	                participant.setPname(rs.getString(2));
	                participant.setAge(rs.getInt(3));
	                participant.setGender(rs.getString(4));
	                participant.setPhone(rs.getString(5));
	                participant.setEmail(rs.getString(6));
	                participant.setBid(rs.getInt(7));
	            	System.out.println("[DB] Participat "+ pid +" listed");
	            	return participant;
	            }else {
	            System.out.println("[DB] Participant not found");
	            }
	            return participant;
	        }
	    });
	}   

    //DONE
    //Override Retrieve a specific participant to check if registered to Batch
    public Participants getParticipant(String pname, int bid) throws ClassNotFoundException, SQLException {
		ApplicationContext ac=new ClassPathXmlApplicationContext("zumba.xml");
		String sql = "SELECT * FROM participants WHERE pname ='"+pname+"' AND bid ='"+bid+"'";
		Participants participant = ac.getBean(Participants.class);
        return temp.query(sql, new ResultSetExtractor<Participants>() {
	        public Participants extractData(ResultSet rs) throws SQLException, DataAccessException {
	            if (rs.next()) { 
	            	participant.setPid(rs.getInt(1));
	                participant.setPname(rs.getString(2));
	                participant.setAge(rs.getInt(3));
	                participant.setGender(rs.getString(4));
	                participant.setPhone(rs.getString(5));
	                participant.setEmail(rs.getString(6));
	                participant.setBid(rs.getInt(7));
	            	System.out.println("[DB] Participant displayed");
	            	return participant;
	            }else {
	            System.out.println("[DB] Participant not found");
	            }
	            return participant;
	        }
	    });
	}   

    //DONE
    // Update
    public int updateParticipant(Participants participant) throws ClassNotFoundException, SQLException {
        int result = 0;
        String pname = participant.getPname();
        int age = participant.getAge();
        String gender = participant.getGender();
        String phone = participant.getPhone();
        String email = participant.getEmail();
        int bid = participant.getBid();
        int pid = participant.getPid();
        String sql = "UPDATE participants SET pname ='" + pname + "' , age = '" + age + "', gender = '" + gender + "', phone ='" + phone + "', email ='" + email + "', bid ='" + bid + "' WHERE pid ='" + pid + "'";
        result = temp.update(sql);
	    if(result > 0) {
	    	System.out.println("[DB] Participat Edited");
	    }else {
	    	System.out.println("[DB] Participat not edited");
	    }
	    return result;
	}    
 
    //DONE
    // Override Update participant when username and email updated
    public int updateParticipant(String oldUserName, String newUserName, String newEmail) throws ClassNotFoundException, SQLException {
            String sql = "UPDATE participants SET pname ='"+newUserName+"', email ='"+newEmail+"' WHERE pname ='"+oldUserName+"'";            
            int result = 0;
            result = temp.update(sql);
            if (result >0 ) {
            	System.out.println("[DB] Participat updated: " + newUserName.toUpperCase());
            }else {
            	System.out.println("[DB] Participat : " + newUserName.toUpperCase() + " not registered to any Batch");
            }
        return result;
    }
    
    //DONE
    // unregister from a Batch
    public int unregisterParticipant(String username, int bid) throws ClassNotFoundException, SQLException {
        int result = 0;
        String sql = "DELETE FROM participants WHERE pname ='" + username + "' AND bid ='" + bid + "'";
        try {
			result = temp.update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
        if (result > 0) {
        	System.out.println("[DB] Participant Unregistered");
        }else {
        	System.out.println("[DB] Participant Unregister failed");
        }
    return result;
    }

    //DONE
    // Delete
    public int deleteParticipant(int pid) throws ClassNotFoundException, SQLException {
        String sql = "DELETE FROM participants WHERE pid ='" + pid + "'";
        int result = 0;
        try {
			result = temp.update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
        if (result > 0) {
        	System.out.println("[DB] Participant deleted");
        }else {
        	System.out.println("[DB] Participant delete failed");
        }
    return result;
    }
    
    //DONE
    // override Delete participant when user deleted
    public int deleteParticipant(String username) throws ClassNotFoundException, SQLException {
        int result = 0;
        String sql = "DELETE FROM participants WHERE pname ='"+username+"'";
        result = temp.update(sql);
        if(result > 0) {
            System.out.println("[DB] Participat "+ username.toUpperCase() +" deleted from all Batches");
        }else {
            System.out.println("[DB] Participat "+ username.toUpperCase() +" not registered to any Batch");
        }
        return result;
    }
    
    //DONE
    //Send SMS
    public String sendSMS(String pname){
    	System.out.println("SMS sent to: " + pname);
		return pname;
    }
    
    //DONE
    //Send Email
    public String sendEmail(String pname){
    	System.out.println("Email sent to: " + pname);
		return pname;
    }
}

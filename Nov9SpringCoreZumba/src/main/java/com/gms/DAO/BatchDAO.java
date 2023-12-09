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

import com.gms.model.Batch;
import com.gms.model.Participants;

public class BatchDAO {
	private JdbcTemplate temp;

	public void setTemp(JdbcTemplate temp) {
		this.temp = temp;
	}

	// DONE
	// Insert
	public int insertBatch(Batch batch) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "INSERT INTO batch VALUES ('" + 0 + "' ,'" + batch.getBname() + "', '" + batch.getInstructor()
				+ "', '" + batch.getStartTime() + "', '" + batch.getStartDate() + "')";
		try {
			result = temp.update(sql);
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result > 0) {
			System.out.println("[DB] Batch added");
		} else {
			System.out.println("[DB] Batch not added");
		}
		return result;
	}

	// DONE
	// Retrieve all batches
	public List<Batch> displayBatches() throws ClassNotFoundException, SQLException {
		String sql = "SELECT * FROM batch ORDER BY bid";
		return temp.query(sql, new ResultSetExtractor<List<Batch>>() {
			@Override
			public List<Batch> extractData(ResultSet rs) throws SQLException, DataAccessException {
				ArrayList<Batch> batches = new ArrayList<Batch>();
				while (rs.next()) {
					Batch batch = new Batch();
					batch.setBid(rs.getInt(1));
					batch.setBname(rs.getString(2));
					batch.setInstructor(rs.getString(3));
					batch.setStartTime(rs.getString(4));
					batch.setStartDate(rs.getString(5));
					batches.add(batch);
				}
				System.out.println("[DB] Batches listed");
				return batches;
			}
		});
	}

	// DONE
	// Retrieve a specific batch
	public Batch displayBatch(int bid) throws ClassNotFoundException, SQLException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		String sql = "SELECT * FROM batch WHERE bid =" + bid + "";
		Batch batch = ac.getBean(Batch.class);
		return temp.query(sql, new ResultSetExtractor<Batch>() {
			@Override
			public Batch extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					batch.setBid(rs.getInt(1));
					batch.setBname(rs.getString(2));
					batch.setInstructor(rs.getString(3));
					batch.setStartTime(rs.getString(4));
					batch.setStartDate(rs.getString(5));
					System.out.println("[DB] Batch " + bid + " displayed");
					return batch;
				} else {
					System.out.println("[DB] Batch not found");
				}
				return batch;
			}
		});
	}

	// DONE
	// Update
	public int editBatch(Batch batch) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "UPDATE batch SET bname ='" + batch.getBname() + "', instructor ='" + batch.getInstructor()
				+ "', startTime ='" + batch.getStartTime() + "', startDate ='" + batch.getStartDate() + "' WHERE bid ='"
				+ batch.getBid() + "'";
		try {
			result = temp.update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		if (result > 0) {
			System.out.println("[DB] Batch edited");
		} else {
			System.out.println("[DB] Batch edit failed");
		}
		return result;
	}

	// DONE
	// Delete
	public int deleteBatch(int bid) throws ClassNotFoundException, SQLException {
		int result = 0;
		String sql = "DELETE FROM batch WHERE bid =" + bid + "";
		try {
			result = temp.update(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		if (result > 0) {
			System.out.println("[DB] Batch deleted");
		} else {
			System.out.println("[DB] Batch delete failed");
		}
		return result;
	}

	// DONE
	// Start Batch
	public int startBatch(int bid) throws ClassNotFoundException, SQLException {
		ApplicationContext ac = new ClassPathXmlApplicationContext("zumba.xml");
		ParticipantsDAO pdao = ac.getBean(ParticipantsDAO.class);
		List<Participants> list = null;
		try {
			list = pdao.BatchParticipants(bid);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int result = 0;
		try {
			for (Participants batch : list) {
				String name = batch.getPname().toUpperCase();
				pdao.sendSMS(name);
				pdao.sendEmail(name);
				result++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[DB] Batch started");
		return result;
	}

}
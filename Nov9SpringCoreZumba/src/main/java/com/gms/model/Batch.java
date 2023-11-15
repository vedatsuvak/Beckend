package com.gms.model;

public class Batch {
    private int bid;
    private String bname;
    private String instructor;
    private String startTime;
    private String startDate;

    public Batch() {
	// TODO Auto-generated constructor stub
    }
    
	public Batch(int bid, String bname, String instructor, String startTime, String startDate) {
		super();
		this.bid = bid;
		this.bname = bname;
		this.instructor = instructor;
		this.startTime = startTime;
		this.startDate = startDate;
	}

	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getInstructor() {
		return instructor;
	}
	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	@Override
	public String toString() {
		return "Batch [bid=" + bid + ", bname=" + bname + ", instructor=" + instructor + ", startTime=" + startTime
				+ ", startDate=" + startDate + "]";
	}
	
}

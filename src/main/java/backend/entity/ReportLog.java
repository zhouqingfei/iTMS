package backend.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReportLog {

	private int logId;
	private String logNumber;
	private String logName;
	private String loginId;
	@DateTimeFormat(pattern="yyyy-MM-dd") 
	private Date modifyTime;
	public int getLogId() {
		return logId;
	}
	public void setLogId(int logId) {
		this.logId = logId;
	}
	public String getLogNumber() {
		return logNumber;
	}
	public void setLogNumber(String logNumber) {
		this.logNumber = logNumber;
	}
	public String getLogName() {
		return logName;
	}
	public void setLogName(String logName) {
		this.logName = logName;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	
}

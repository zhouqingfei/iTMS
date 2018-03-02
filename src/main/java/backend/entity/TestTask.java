package backend.entity;

import java.util.Date;

public class TestTask {
	private int id;
	private String testTaskName;
	private String suitName;
	private Date startTime;
	private Date endTime;
	private String testTaskState;
	private String loginId;
	private String result;

	private String process;
	
	private String specialCaseName;
	private String machineType;
	private String testCategory;
	private String testTaskDescribe;
	private String poolType;
	private String poolSuitOrCase;
	private String machineCategory;
	private String machineInfo;
	private String temInfo;
	public String getTemInfo() {
		return temInfo;
	}
	public void setTemInfo(String temInfo) {
		this.temInfo = temInfo;
	}
	public String getSutInfo() {
		return sutInfo;
	}
	public void setSutInfo(String sutInfo) {
		this.sutInfo = sutInfo;
	}
	private String sutInfo;
	
	private String testCaseCount;
	private String testCaseInfo;
	
	public String getTestCaseCount() {
		return testCaseCount;
	}
	public void setTestCaseCount(String testCaseCount) {
		this.testCaseCount = testCaseCount;
	}
	public String getTestCaseInfo() {
		return testCaseInfo;
	}
	public void setTestCaseInfo(String testCaseInfo) {
		this.testCaseInfo = testCaseInfo;
	}
	public String getSpecialCaseName() {
		return specialCaseName;
	}
	public void setSpecialCaseName(String specialCaseName) {
		this.specialCaseName = specialCaseName;
	}
	public String getMachineType() {
		return machineType;
	}
	public void setMachineType(String machineType) {
		this.machineType = machineType;
	}
	public String getTestCategory() {
		return testCategory;
	}
	public void setTestCategory(String testCategory) {
		this.testCategory = testCategory;
	}
	public String getTestTaskDescribe() {
		return testTaskDescribe;
	}
	public void setTestTaskDescribe(String testTaskDescribe) {
		this.testTaskDescribe = testTaskDescribe;
	}
	public String getPoolType() {
		return poolType;
	}
	public void setPoolType(String poolType) {
		this.poolType = poolType;
	}
	public String getPoolSuitOrCase() {
		return poolSuitOrCase;
	}
	public void setPoolSuitOrCase(String poolSuitOrCase) {
		this.poolSuitOrCase = poolSuitOrCase;
	}
	public String getMachineCategory() {
		return machineCategory;
	}
	public void setMachineCategory(String machineCategory) {
		this.machineCategory = machineCategory;
	}
	public String getMachineInfo() {
		return machineInfo;
	}
	public void setMachineInfo(String machineInfo) {
		this.machineInfo = machineInfo;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTestTaskName() {
		return testTaskName;
	}
	public void setTestTaskName(String testTaskName) {
		this.testTaskName = testTaskName;
	}
	public String getSuitName() {
		return suitName;
	}
	public void setSuitName(String suitName) {
		this.suitName = suitName;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getTestTaskState() {
		return testTaskState;
	}
	public void setTestTaskState(String testTaskState) {
		this.testTaskState = testTaskState;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
}

package backend.entity;

import java.util.Date;

public class TestSuit {
	private int id;
	private String testSuitName;
	private String temSut;
	private String testSuitCategory;
	private Date modifyTime;
	private String userLoginId;
	private String testDescibe;
	private String testSuitDescribe;
	private String testCaseInfo;
	private String testSuitExplain;
	
	public String getTestSuitExplain() {
		return testSuitExplain;
	}
	public void setTestSuitExplain(String testSuitExplain) {
		this.testSuitExplain = testSuitExplain;
	}
	public String getTestCaseInfo() {
		return testCaseInfo;
	}
	public void setTestCaseInfo(String testCaseInfo) {
		this.testCaseInfo = testCaseInfo;
	}
	public int getId() {
		return id;
	}
	public String getTestDescibe() {
		return testDescibe;
	}
	public void setTestDescibe(String testDescibe) {
		this.testDescibe = testDescibe;
	}
	public String getTestSuitDescribe() {
		return testSuitDescribe;
	}
	public void setTestSuitDescribe(String testSuitDescribe) {
		this.testSuitDescribe = testSuitDescribe;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTestSuitName() {
		return testSuitName;
	}
	public void setTestSuitName(String testSuitName) {
		this.testSuitName = testSuitName;
	}
	
	public String getTemSut() {
		return temSut;
	}
	public String getUserLoginId() {
		return userLoginId;
	}
	public void setUserLoginId(String userLoginId) {
		this.userLoginId = userLoginId;
	}
	public void setTemSut(String temSut) {
		this.temSut = temSut;
	}
	public String getTestSuitCategory() {
		return testSuitCategory;
	}
	public void setTestSuitCategory(String testSuitCategory) {
		this.testSuitCategory = testSuitCategory;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	
}
